#!/bin/bash
source ./config.sh

TABLE_NAME="ads_daily_monitor"
SCHEMA="vehicle_id:STRING,daily_distance:FLOAT,date:STRING"
bq mk --table --description "ads_daily_monitor" \
${PROJECT_ID}:${DATASET_NAME}.${TABLE_NAME} ${SCHEMA}