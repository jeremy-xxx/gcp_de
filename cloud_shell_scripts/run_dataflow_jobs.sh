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

gcloud dataflow jobs run "${PUBSUB_TOPIC1}_to_cs_job" \
    --gcs-location "gs://dataflow-templates-${REGION}/latest/Cloud_PubSub_to_GCS_Text" \
    --region ${REGION} --max-workers 1 --num-workers 1 \
    --staging-location "gs://${BUCKET_NAME}/temp" \
    --parameters \
inputTopic=projects/${PROJECT_ID}/topics/${PUBSUB_TOPIC1},\
outputDirectory=gs://${BUCKET_NAME}/${PUBSUB_TOPIC1}/,\
outputFilenamePrefix=${PUBSUB_TOPIC1}-,\
outputFilenameSuffix=.txt

gcloud dataflow jobs run "${PUBSUB_TOPIC2}_to_cs_job" \
    --gcs-location "gs://dataflow-templates-${REGION}/latest/Cloud_PubSub_to_GCS_Text" \
    --region ${REGION} --max-workers 1 --num-workers 1 \
    --staging-location "gs://${BUCKET_NAME}/temp" \
    --parameters \
inputTopic=projects/${PROJECT_ID}/topics/${PUBSUB_TOPIC2},\
outputDirectory=gs://${BUCKET_NAME}/${PUBSUB_TOPIC2}/,\
outputFilenamePrefix=${PUBSUB_TOPIC2}-,\
outputFilenameSuffix=.txt

gcloud dataflow jobs run "${PUBSUB_TOPIC3}_to_cs_job" \
    --gcs-location "gs://dataflow-templates-${REGION}/latest/Cloud_PubSub_to_GCS_Text" \
    --region ${REGION} --max-workers 1 --num-workers 1 \
    --staging-location "gs://${BUCKET_NAME}/temp" \
    --parameters \
inputTopic=projects/${PROJECT_ID}/topics/${PUBSUB_TOPIC3},\
outputDirectory=gs://${BUCKET_NAME}/${PUBSUB_TOPIC3}/,\
outputFilenamePrefix=${PUBSUB_TOPIC3}-,\
outputFilenameSuffix=.txt

# ref https://cloud.google.com/dataflow/docs/guides/templates/provided-templates