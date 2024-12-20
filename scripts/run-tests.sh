#!/bin/bash

cd /app/tests
npx playwright test

source /app/config.txt
echo $bucketname

if [ $? -eq 0 ]; then
    echo "Tests passed. Uploading prices.txt to S3..."
    aws s3 cp /app/prices.txt s3://$bucketname/
else
    echo "Tests failed. Skipping S3 upload."
    exit 1
fi