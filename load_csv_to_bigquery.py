from google.cloud import bigquery
import os
import glob

# Initialize a BigQuery client to interact with the service
client = bigquery.Client()

# Assign the dataset name where you want to create the tables. This dataset should already been created in bigquery
dataset_name = 'sensor_data'

# Find all CSV files in the data directory and its subdirectories
data_folder = 'data'
csv_files = glob.glob(f'{data_folder}/**/dataset_*.csv', recursive=True)

# Group CSV files by the file name (without the path and extension)
csv_files_grouped = {}
for csv_file in csv_files:
    base_name = os.path.basename(csv_file)
    table_name = f'ods_{os.path.splitext(base_name)[0]}'
    if table_name not in csv_files_grouped:
        csv_files_grouped[table_name] = []
    csv_files_grouped[table_name].append(csv_file)

def create_table_and_load_data(dataset_name, table_name, csv_files):
    """
    Creates a new BigQuery table and loads data from the specified CSV files.
    If a table with the same name already exists, it overwrites it.
    Also creates a partitioned table based on a timestamp column.

    Args:
    dataset_name (str): The dataset name in BigQuery.
    group_info (tuple): A tuple containing paths to CSV files, table name, and schema.
    """
    table_id = f"{client.project}.{dataset_name}.{table_name}"
    temp_table_id = f"{table_id}_temp"

    # Create a temporary table
    temp_table = bigquery.Table(temp_table_id)
    client.create_table(temp_table, exists_ok=True)

    # Load data from each CSV file into the temporary table
    for csv_file in csv_files:
        job_config = bigquery.LoadJobConfig(
            source_format=bigquery.SourceFormat.CSV,
            skip_leading_rows=1,
            autodetect=True
        )
        with open(csv_file, "rb") as source_file:
            job = client.load_table_from_file(source_file, temp_table_id, job_config=job_config)
        job.result()
        print(f"Loaded {job.output_rows} rows into {temp_table_id} from {csv_file}")

    # Transform and load data into the final partitioned table
    job_config = bigquery.QueryJobConfig()
    sql = f"""
    CREATE OR REPLACE TABLE `{table_id}`
    PARTITION BY TIMESTAMP_TRUNC(timestamp_formatted, DAY) AS
    SELECT *, TIMESTAMP_SECONDS(CAST(timestamp AS INT64)) as timestamp_formatted
    FROM `{temp_table_id}`;
    """
    job = client.query(sql, job_config=job_config)
    job.result()

    # Clean up: delete the temporary table
    client.delete_table(temp_table_id, not_found_ok=True)
    print(f"Temporary table {temp_table_id} deleted.")

    print(f"Data transformed and loaded into partitioned table {table_id}.")

# Iterate over the grouped CSV files and load them into BigQuery
for table_name, csv_files in csv_files_grouped.items():
    create_table_and_load_data(dataset_name, table_name, csv_files)

print("All tables created and data loaded.")

# Sample query to select data from a partitioned table within a date range
# Replace `your_project.your_dataset.your_table` with your actual table path
sample_query = """
SELECT *
FROM `your_project.your_dataset.your_table`
WHERE _PARTITIONTIME BETWEEN TIMESTAMP('2023-01-01') AND TIMESTAMP('2023-01-31')
"""



