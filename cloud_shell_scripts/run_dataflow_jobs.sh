#!/bin/bash
source ./config.sh

gcloud dataflow jobs run "${PUBSUB_TOPIC1}_to_bq_job" \
    --gcs-location "gs://dataflow-templates-us-central1/latest/PubSub_to_BigQuery" \
    --region $REGION \
    --staging-location "gs://${BUCKET_NAME}/temp" \
    --parameters inputTopic="projects/${PROJECT_ID}/topics/${PUBSUB_TOPIC1}", \
        outputTableSpec="${PROJECT_ID}:${DATASET_NAME}.${BQ_TABLE_NAME1}"

gcloud dataflow jobs run "${PUBSUB_TOPIC2}_to_bq_job" \
    --gcs-location "gs://dataflow-templates-us-central1/latest/PubSub_to_BigQuery" \
    --region $REGION \
    --staging-location "gs://${BUCKET_NAME}/temp" \
    --parameters inputTopic="projects/${PROJECT_ID}/topics/${PUBSUB_TOPIC2}", \
        outputTableSpec="${PROJECT_ID}:${DATASET_NAME}.${BQ_TABLE_NAME2}"

gcloud dataflow jobs run "${PUBSUB_TOPIC3}_to_bq_job" \
    --gcs-location "gs://dataflow-templates-us-central1/latest/PubSub_to_BigQuery" \
    --region $REGION \
    --staging-location "gs://${BUCKET_NAME}/temp" \
    --parameters inputTopic="projects/${PROJECT_ID}/topics/${PUBSUB_TOPIC3}", \
        outputTableSpec="${PROJECT_ID}:${DATASET_NAME}.${BQ_TABLE_NAME3}"


gcloud dataflow jobs run "${PUBSUB_TOPIC1}_to_cs_job" \
    --gcs-location "gs://dataflow-templates/latest/PubSub_to_Text" \
    --region $REGION \
    --parameters inputTopic="projects/${PROJECT_ID}/topics/${PUBSUB_TOPIC1}", \
    output=gs://${BUCKET_NAME}/${PUBSUB_TOPIC1}

gcloud dataflow jobs run "${PUBSUB_TOPIC2}_to_cs_job" \
    --gcs-location "gs://dataflow-templates/latest/PubSub_to_Text" \
    --region $REGION \
    --parameters inputTopic="projects/${PROJECT_ID}/topics/${PUBSUB_TOPIC2}", \
    output=gs://${BUCKET_NAME}/${PUBSUB_TOPIC2}

gcloud dataflow jobs run "${PUBSUB_TOPIC3}_to_cs_job" \
    --gcs-location "gs://dataflow-templates/latest/PubSub_to_Text" \
    --region $REGION \
    --parameters inputTopic="projects/${PROJECT_ID}/topics/${PUBSUB_TOPIC3}", \
    output=gs://${BUCKET_NAME}/${PUBSUB_TOPIC3}
