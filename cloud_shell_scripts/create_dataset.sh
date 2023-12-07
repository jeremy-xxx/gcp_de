#!/bin/bash
source ./config.sh

bq mk --location=$REGION --dataset ${PROJECT_ID}:${DATASET_NAME}

