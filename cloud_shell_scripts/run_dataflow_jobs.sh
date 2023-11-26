#!/bin/bash
source ./config.sh

gcloud dataflow jobs run "${PUBSUB_TOPIC1}_to_bq_job" \
    --gcs-location "gs://dataflow-templates-${REGION}/latest/PubSub_to_BigQuery" \
    --region $REGION --max-workers 1 --num-workers 1 \
    --staging-location "gs://${BUCKET_NAME}/temp" \
    --parameters inputTopic="projects/${PROJECT_ID}/topics/${PUBSUB_TOPIC1}",outputTableSpec="${PROJECT_ID}:${DATASET_NAME}.${BQ_TABLE_NAME1}"

gcloud dataflow jobs run "${PUBSUB_TOPIC2}_to_bq_job" \
    --gcs-location "gs://dataflow-templates-${REGION}/latest/PubSub_to_BigQuery" \
    --region $REGION --max-workers 1 --num-workers 1 \
    --staging-location "gs://${BUCKET_NAME}/temp" \
    --parameters inputTopic="projects/${PROJECT_ID}/topics/${PUBSUB_TOPIC2}",outputTableSpec="${PROJECT_ID}:${DATASET_NAME}.${BQ_TABLE_NAME2}"

gcloud dataflow jobs run "${PUBSUB_TOPIC3}_to_bq_job" \
    --gcs-location "gs://dataflow-templates-${REGION}/latest/PubSub_to_BigQuery" \
    --region $REGION --max-workers 1 --num-workers 1 \
    --staging-location "gs://${BUCKET_NAME}/temp" \
    --parameters inputTopic="projects/${PROJECT_ID}/topics/${PUBSUB_TOPIC3}",outputTableSpec="${PROJECT_ID}:${DATASET_NAME}.${BQ_TABLE_NAME3}"

# ref https://cloud.google.com/dataflow/docs/guides/templates/provided-templates