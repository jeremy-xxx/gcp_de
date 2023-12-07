# GCP Data Engineering Guide

## Data Engineer
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
Run the `load_csv_to_bigquery.py` to batch load CSV files into temporary BigQuery tables.
```sh
python load_csv_to_bigquery.py
```

### 5. Create and Populate BigQuery ODS Partitioned Tables
Run the `partition_bigquery_table.py` to create ODS partitioned tables from temporary table data and delete the temporary tables afterward.
```sh
python partition_bigquery_table.py
```
### 6. Create Cloud Storage subscription for each topic
#### 6.1 [Grant the Storage Admin (roles/storage.admin) role to the Pub/Sub service account.](https://cloud.google.com/pubsub/docs/create-cloudstorage-subscription)
#### 6.2 Execute the following:
```sh
./create_cloud_storage_sub.sh
```

### 7. Create Real-time Dataflow Jobs
Set up real-time Dataflow jobs to write data from Pub/Sub topics to BigQuery ODS partitioned tables by running:
```sh
./run_dataflow_jobs.sh
```

### 8. Create Ads table
Execute the following:
```sh
./create_ads_table.sh
```

### 9. Create scheduled sql job
#### 9.1 Deploy cloud function
Execute the following:
```sh
./deploy_cloud_function.sh
```
#### 9.2 Create cloud scheduler
Execute the following:
```sh
./create_cloud_scheduler.sh
```

### 10. Simulate IoT Device Data Streaming to Pub/Sub
To simulate real-time JSON data streaming from IoT devices to Pub/Sub, use:
```sh
python simulation_json_to_pubsub.py
```

## Data Visualization

### 1. Connect to BigQuery
-   On the Home ribbon in Power BI Desktop, click  **Get Data**  and then  **More…**.
-  In the open window, type “_bigquery_” into the search bar or select the  **Database** category on the left, then find and select  **Google BigQuery**. Click  **Connect**.

![enter image description here](https://blog.coupler.io/wp-content/uploads/2021/08/2-select-google-bigquery.png)
- Now you need to connect BigQuery to Power BI. Click the **Sign in** button and follow the usual flow.![enter image description here](https://blog.coupler.io/wp-content/uploads/2021/08/3-sign-in-google-bigquery.png)
-  A Navigator window will appear in which you need to choose a BigQuery Project, a dataset, and a table to load data from.
- The last step of the Power BI BigQuery connector setup is to click **Load** and choose **DirectQuery** to set up a live connection to our dataset.

### 2. Create Report

#### **Map**
In order to create the map for location tracking, a **Map** is created by dragging the columns `latitude` and `longitude` into the corresponding fields. Then add the column `vehicle_id` into the **Filters on this visual** section, which allows for filtering to monitor specific vehicles.

#### **HDOP vs VDOP by Vehicle**
For the HDOP vs VDOP scatter plot, assign the HDOP values to the X-axis and VDOP values to the Y-axis, differentiating data points by `vehicle_id`.

#### **Average Speed per Second by Vehicle**
Plot the average speed per second by assigning `vehicle_id` to the category axis and average speed values to the value axis.

#### **Total Distance per Vehicle**
To visualize the total distance, use a bar chart with `vehicle_id` on the category axis and total distance values on the value axis.

### 3. Create a Dashboard

After finishing the design of the report, simply choose **Pin to the dashboard** on the upper right of the toolbar to create a new or save to an existing dashboard. 
![enter image description here](https://learn.microsoft.com/en-us/power-bi/create-reports/media/service-dashboard-pin-live-tile-from-report/power-bi-pin.png)



![enter image description here](https://learn.microsoft.com/en-us/power-bi/create-reports/media/service-dashboard-pin-live-tile-from-report/pbi-pin-live-page-dialog.png)
