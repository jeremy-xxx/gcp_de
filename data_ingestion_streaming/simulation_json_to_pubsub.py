import time
import pandas as pd
from google.cloud import pubsub_v1
from datetime import datetime
import json
from concurrent.futures import ThreadPoolExecutor
import sys
from pathlib import Path
parent_dir = Path(__file__).resolve().parents[1]
sys.path.append(str(parent_dir))
import config
# Configure
project_id = config.PROJECT_ID
data_folder = config.STREAMING_DATA_FOLDER

# Initialize Pub/Sub publisher client
publisher = pubsub_v1.PublisherClient()

# Define the datasets and corresponding topics and sleep times
datasets = [
    {'topic_id': config.PUBSUB_TOPIC1, 'csv_filename': 'dataset_gps.csv', 'sleep_time': 1},
    {'topic_id': config.PUBSUB_TOPIC2, 'csv_filename': 'dataset_mpu_left.csv', 'sleep_time': 0.01},
    {'topic_id': config.PUBSUB_TOPIC3, 'csv_filename': 'dataset_mpu_right.csv', 'sleep_time': 0.01}
]


def publish_data(dataset):
    topic_path = publisher.topic_path(project_id, dataset['topic_id'])
    csv_file_path = f'{data_folder}/PVS_2/{dataset["csv_filename"]}'
    df = pd.read_csv(csv_file_path)
    df['vehicle_id'] = 'v1'

    for index, row in df.iterrows():
        # Get current datetime object
        current_dt_object = datetime.now()

        # Convert to UTC time format string
        current_utc_format = current_dt_object.strftime("%Y-%m-%d %H:%M:%S UTC")

        # Get Unix timestamp (seconds) including fractional microseconds
        current_timestamp = current_dt_object.timestamp()

        # Convert the row to a JSON string with additional timestamp fields
        message_data = row.dropna().to_dict()
        message_data['timestamp'] = current_timestamp
        message_data['timestamp_formatted'] = current_utc_format
        message_json = json.dumps(message_data)
        print(message_json)

        # Publish the message to the topic
        publisher.publish(topic_path, data=message_json.encode('utf-8'))

        # Sleep between publishing messages
        time.sleep(dataset['sleep_time'])


# Use ThreadPoolExecutor to run each dataset publishing in parallel
with ThreadPoolExecutor(max_workers=len(datasets)) as executor:
    futures = [executor.submit(publish_data, dataset) for dataset in datasets]

    # Wait for all futures to complete
    for future in futures:
        future.result()
