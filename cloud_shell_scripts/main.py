from google.cloud import bigquery
import sys
from pathlib import Path

parent_dir = Path(__file__).resolve().parents[1]
sys.path.append(str(parent_dir))
import config


def execute_sql(request):
    client = bigquery.Client()

    # Replace these variables with your BigQuery details.
    project_id = config.PROJECT_ID
    dataset_id = config.DATASET_NAME
    ods_table_id = 'ods_dataset_gps'
    ads_table_id = 'ads_daily_monitor'

    # Write your SQL query here.
    sql = f"""
    INSERT INTO `{project_id}.{dataset_id}.{ads_table_id}` (vehicle_id, daily_distance	, date)
    SELECT
      vehicle_id,
      SUM(distance_meters) AS daily_distance,
      FORMAT_TIMESTAMP('%Y-%m-%d', timestamp_formatted) AS date
    FROM `{project_id}.{dataset_id}.{ods_table_id}`
    WHERE DATE(timestamp_formatted) = DATE_SUB(CURRENT_DATE(), INTERVAL 1 DAY)
    GROUP BY date, vehicle_id
    """

    query_job = client.query(sql)  # Make an API request.
    query_job.result()  # Wait for the job to complete.

    return 'Query executed successfully.'
