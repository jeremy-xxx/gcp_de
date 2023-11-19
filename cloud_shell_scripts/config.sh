# config.sh
export PROJECT_ID="PROJECT_ID"
export REGION="us-central1"

export SERVICE_ACCOUNT_NAME="service-account-gcp-de"

export BUCKET_NAME="UNIQUE_BUCKET_NAME"

export PUBSUB_TOPIC1="gps"
export PUBSUB_TOPIC2="mpu_left"
export PUBSUB_TOPIC3="mpu_right"

export DATASET_NAME="sensor_data"
export BQ_TABLE_NAME1="ods_dataset_${PUBSUB_TOPIC1}"
export BQ_TABLE_NAME2="ods_dataset_${PUBSUB_TOPIC2}"
export BQ_TABLE_NAME3="ods_dataset_${PUBSUB_TOPIC3}"