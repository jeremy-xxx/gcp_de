#!/bin/bash
# 加载配置文件
source ./config.sh

bq mk --location=$REGION --dataset ${PROJECT_ID}:${DATASET_NAME}

