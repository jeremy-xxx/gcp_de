# GCP Data Engineering Guide

### Preparation
- Clone the project in cloud shell
```sh
git clone https://github.com/jeremy-xxx/gcp_de
```
- Set the right PROJECT_ID in config.py and config.sh.
- Set a unique BUCKET_NAME in config.sh
- Change the scripts permissions to make it executable. 
```sh
find gcp_de -type f -exec chmod +x {} \;
```

### 1. Create a Cloud Storage Bucket
Run the script:
```sh
./create_storage_bucket.sh
```

### 2. Create Pub/Sub Topics
Execute the following:
```sh
./create_pubsub_topics.sh
```

### 3. Create Bigquery Dataset
Execute the following:
```sh
./create_dataset.sh
```

### 4. Create BigQuery Temporary Tables and Load CSV Data
Locally run the `load_csv_to_bigquery.py` to batch load CSV files into temporary BigQuery tables.

### 5. Create and Populate BigQuery ODS Partitioned Tables
Locally run the `partition_bigquery_table.py` to create ODS partitioned tables from temporary table data and delete the temporary tables afterward.

### 6. Create Real-time Dataflow Jobs
Set up real-time Dataflow jobs to write data from Pub/Sub topics to Cloud Storage for backup and to BigQuery ODS partitioned tables by running:
```sh
./run_dataflow_jobs.sh
```

### 7. Simulate IoT Device Data Streaming to Pub/Sub
To simulate real-time JSON data streaming from IoT devices to Pub/Sub, use:
```sh
simulation_json_to_pubsub.py
```