#!/bin/bash
source ./config.sh

gcloud scheduler jobs create http execute_sql \
    --schedule="0 1 * * *" \
    --uri="https://${REGION}-${PROJECT_ID}.cloudfunctions.net/execute_sql" \
    --http-method=GET \
    --time-zone="America/Chicago"

# test: gcloud scheduler jobs run execute_sql
