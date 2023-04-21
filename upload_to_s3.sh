#!/bin/bash
if [ -z "$1" ]
then
      echo "Input web folder path parameter is empty"
      exit 1
fi
S3_BUCKET="s3://www.umnisoft.com"
AWS_PROFILE="martin"
WEB_FOLDER="$1"
AWS_DEFAULT_REGION="us-east-1"
## Upload files to S3
aws s3 cp --recursive ${WEB_FOLDER} --profile ${AWS_PROFILE} --region ${AWS_DEFAULT_REGION} ${S3_BUCKET}/html
# Setup Cache Clear header
s3cmd --recursive modify --add-header="Cache-Control:max-age=0, no-cache, no-store, must-revalidate" ${S3_BUCKET}/html
# Make it public
s3cmd setacl ${S3_BUCKET}/html --acl-public --recursive
