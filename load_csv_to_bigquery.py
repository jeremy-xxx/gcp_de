import os
import glob
import pandas as pd
from google.cloud import bigquery

# Initialize a BigQuery client to interact with the Google BigQuery service.
# This requires having the GOOGLE_APPLICATION_CREDENTIALS environment variable set.
client = bigquery.Client()


def read_csv_file(csv_file, subfolder_name):
    """
    Reads a CSV file into a pandas DataFrame and adds a 'data_source' column.

    Parameters:
    - csv_file: The path to the CSV file.
    - subfolder_name: The name of the subfolder where the CSV file is located, which will be used as the value for the 'data_source' column.

    Returns:
    - A pandas DataFrame with the CSV data and an additional 'data_source' column.
    """
    df = pd.read_csv(csv_file)
    df['data_source'] = subfolder_name
    return df


def load_dataframe_to_bigquery(df, dataset_name, table_name):
    """
    Loads a pandas DataFrame to a BigQuery table.

    Parameters:
    - df: The pandas DataFrame to load.
    - dataset_name: The name of the dataset in BigQuery where the table will be created.
    - table_name: The name of the BigQuery table where the DataFrame will be loaded.

    The function waits for the job to complete and prints the number of rows loaded.
    """
    table_id = f"{client.project}.{dataset_name}.{table_name}_temp"
    job_config = bigquery.LoadJobConfig(autodetect=True)
    job = client.load_table_from_dataframe(df, table_id, job_config=job_config)
    job.result()  # Waits for the job to complete
    print(f"Loaded {job.output_rows} rows into {table_id}")


def find_csv_files(data_folder):
    """
    Finds all CSV files in the specified data folder and its subdirectories.

    Parameters:
    - data_folder: The root directory to search for CSV files.

    Returns:
    - A list of paths to the CSV files.
    """
    return glob.glob(f'{data_folder}/**/dataset_*.csv', recursive=True)


def load_csv_to_bigquery(csv_file, dataset_name):
    """
    Processes a single CSV file: reads it into a DataFrame, adds a 'data_source' column, and loads it to BigQuery.

    Parameters:
    - csv_file: The path to the CSV file.
    - dataset_name: The name of the dataset in BigQuery where the table will be created.

    The table name is derived from the CSV file name.
    """
    subfolder_name = os.path.basename(os.path.dirname(csv_file))
    table_name = 'ods_' + os.path.splitext(os.path.basename(csv_file))[0]
    df = read_csv_file(csv_file, subfolder_name)
    load_dataframe_to_bigquery(df, dataset_name, table_name)


def main():
    """
    The main entry point of the script.
    It sets up the dataset name, finds all CSV files in the 'data' folder, and loads each one into BigQuery.
    """
    dataset_name = 'sensor_data'  # Name of the dataset in BigQuery.
    data_folder = 'data'  # Directory containing CSV files.
    csv_files = find_csv_files(data_folder)  # List of CSV file paths.

    for csv_file in csv_files:
        load_csv_to_bigquery(csv_file, dataset_name)

    print("All tables created and data loaded.")

if __name__ == "__main__":
    main()
