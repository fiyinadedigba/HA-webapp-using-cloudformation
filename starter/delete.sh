#!/bin/bash
set -e

REGION=us-east-1
NETWORK_STACK=udagram-network
APP_STACK=udagram-app
BUCKET_NAME=$(jq -r '.[] | select(.ParameterKey=="BucketName") | .ParameterValue' udagram-parameters.json)

echo "Emptying bucket..."
aws s3 rm s3://$BUCKET_NAME --recursive --region $REGION || true

echo "Deleting application stack..."
aws cloudformation delete-stack \
  --region $REGION \
  --stack-name $APP_STACK

aws cloudformation wait stack-delete-complete \
  --region $REGION \
  --stack-name $APP_STACK

echo "Deleting network stack..."
aws cloudformation delete-stack \
  --region $REGION \
  --stack-name $NETWORK_STACK

aws cloudformation wait stack-delete-complete \
  --region $REGION \
  --stack-name $NETWORK_STACK

echo "Deleted."
