#!/bin/bash
source ./config.sh

gcloud pubsub subscriptions create sub_to_bigquery \
    --topic=$PUBSUB_TOPIC1 \
    --bigquery-table=${PROJECT_ID}:${DATASET_NAME}.${BQ_TABLE_NAME1}

gcloud pubsub subscriptions create sub_to_bigquery \
    --topic=$PUBSUB_TOPIC2 \
    --bigquery-table=${PROJECT_ID}:${DATASET_NAME}.${BQ_TABLE_NAME2}

gcloud pubsub subscriptions create sub_to_bigquery \
    --topic=$PUBSUB_TOPIC3 \
    --bigquery-table=${PROJECT_ID}:${DATASET_NAME}.${BQ_TABLE_NAME3}

# https://cloud.google.com/pubsub/docs/create-bigquery-subscription