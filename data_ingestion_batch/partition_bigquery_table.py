from google.cloud import bigquery
import sys
from pathlib import Path
parent_dir = Path(__file__).resolve().parents[1]
sys.path.append(str(parent_dir))
import config

# Initialize a BigQuery client
client = bigquery.Client()

# Set the dataset name where the tables are located
dataset_name = config.DATASET_NAME
dataset_ref = client.dataset(dataset_name)

# Get a list of all tables in the dataset
tables = client.list_tables(dataset_ref)

# Iterate over tables and transform tables with 'temp' in the name
for table in tables:
    # Check if 'temp' is in the table name
    if 'temp' in table.table_id:
        # Set the table_id for the final partitioned table
        table_id = f"{client.project}.{dataset_name}.{table.table_id.replace('_temp', '')}"
        # Set the temp_table_id for the existing table to be transformed
        temp_table_id = f"{client.project}.{dataset_name}.{table.table_id}"

        # Define the SQL query to transform and load data into the final partitioned table
        sql = f"""
        CREATE OR REPLACE TABLE `{table_id}`
        PARTITION BY TIMESTAMP_TRUNC(timestamp_formatted, DAY) AS
        SELECT *, TIMESTAMP_SECONDS(CAST(timestamp AS INT64)) as timestamp_formatted, '' as data
        FROM `{temp_table_id}`;
        """

        # Set job_config to run the query
        job_config = bigquery.QueryJobConfig()

        # Run the query
        job = client.query(sql, job_config=job_config)
        job.result()  # Wait for the job to complete

        print(f"Transformed table {table.table_id} into a partitioned table {table_id.replace('_temp', '')}")

        # Clean up: delete the temporary table
        client.delete_table(temp_table_id, not_found_ok=True)
        print(f"Temporary table {temp_table_id} deleted.")

print("All applicable tables have been transformed into partitioned tables.")
