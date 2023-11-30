gcloud functions deploy execute_sql \
  --runtime python39 \
  --trigger-http \
  --entry-point execute_sql \
  --allow-unauthenticated
