#!/bin/bash
# 加载配置文件
source ./config.sh

gcloud pubsub topics create $PUBSUB_TOPIC1 --project=$PROJECT_ID
gcloud pubsub topics create $PUBSUB_TOPIC2 --project=$PROJECT_ID
gcloud pubsub topics create $PUBSUB_TOPIC3 --project=$PROJECT_ID

