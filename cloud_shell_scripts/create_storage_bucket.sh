#!/bin/bash
# 加载配置文件
source ./config.sh

gsutil mb -l $REGION -c ARCHIVE gs://$BUCKET_NAME/

