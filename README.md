# GCP Data Engineering Guide

### Preparation
- Set the right PROJECT_ID in config.py and config.sh.
- Set a unique BUCKET_NAME in config.sh
- Copy the `cloud_shell_scripts` folder to the Cloud Shell environment. Change the file permissions to make it executable. 


### 1. Create a Service Account and Assign Roles
Navigate to the `cloud_shell_scripts` directory and execute:
```sh
./create_service_account.sh
```

### 2. Download the Service Account Key
Download the newly created service account key (a JSON file) to your local machine. Set the environment variable `GOOGLE_APPLICATION_CREDENTIALS` to the path of the key file.

### 3. Create a Cloud Storage Bucket
Run the script:
```sh
./create_storage_bucket.sh
```

### 4. Create Pub/Sub Topics
Execute the following:
```sh
./create_pubsub_topics.sh
```

### 5. Create Bigquery Dataset
Execute the following:
```sh
./create_dataset.sh
```

### 6. Create BigQuery Temporary Tables and Load CSV Data
Locally run the `load_csv_to_bigquery.py` to batch load CSV files into temporary BigQuery tables.

### 7. Create and Populate BigQuery ODS Partitioned Tables
Locally run the `partition_bigquery_table.py` to create ODS partitioned tables from temporary table data and delete the temporary tables afterward.

### 8. Create Real-time Dataflow Jobs
Set up real-time Dataflow jobs to write data from Pub/Sub topics to Cloud Storage for backup and to BigQuery ODS partitioned tables by running:
```sh
./run_dataflow_jobs.sh
```

### 9. Simulate IoT Device Data Streaming to Pub/Sub
To simulate real-time JSON data streaming from IoT devices to Pub/Sub, use:
```sh
simulation_json_to_pubsub.py
```