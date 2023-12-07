#!/bin/bash
source ./config.sh

gsutil mb -l $REGION -c ARCHIVE gs://$BUCKET_NAME/

