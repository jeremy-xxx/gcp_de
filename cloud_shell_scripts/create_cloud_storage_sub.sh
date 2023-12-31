#!/bin/bash
source ./config.sh

gcloud pubsub subscriptions create ${PUBSUB_TOPIC1}_to_cloud_storage \
    --topic=$PUBSUB_TOPIC1 \
    --cloud-storage-bucket=$BUCKET_NAME \
    --cloud-storage-file-prefix=${PUBSUB_TOPIC1}- \
    --cloud-storage-file-suffix=.txt \
    --cloud-storage-max-bytes=1MB \
    --cloud-storage-max-duration=1m \
    --cloud-storage-output-format=text \
    --cloud-storage-write-metadata

gcloud pubsub subscriptions create ${PUBSUB_TOPIC2}_to_cloud_storage \
    --topic=$PUBSUB_TOPIC2 \
    --cloud-storage-bucket=$BUCKET_NAME \
    --cloud-storage-file-prefix=${PUBSUB_TOPIC2}- \
    --cloud-storage-file-suffix=.txt \
    --cloud-storage-max-bytes=1MB \
    --cloud-storage-max-duration=1m \
    --cloud-storage-output-format=text \
    --cloud-storage-write-metadata

gcloud pubsub subscriptions create ${PUBSUB_TOPIC3}_to_cloud_storage \
    --topic=$PUBSUB_TOPIC3 \
    --cloud-storage-bucket=$BUCKET_NAME \
    --cloud-storage-file-prefix=${PUBSUB_TOPIC3}- \
    --cloud-storage-file-suffix=.txt \
    --cloud-storage-max-bytes=1MB \
    --cloud-storage-max-duration=1m \
    --cloud-storage-output-format=text \
    --cloud-storage-write-metadata

# https://cloud.google.com/pubsub/docs/create-cloudstorage-subscription