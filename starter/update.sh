#!/bin/bash
set -e

REGION=us-east-1
NETWORK_STACK=udagram-network
APP_STACK=udagram-app

echo "Updating network stack..."
aws cloudformation update-stack \
  --region $REGION \
  --stack-name $NETWORK_STACK \
  --template-body file://network.yml \
  --parameters file://network-parameters.json \
  --capabilities CAPABILITY_NAMED_IAM || true

echo "Updating application stack..."
aws cloudformation update-stack \
  --region $REGION \
  --stack-name $APP_STACK \
  --template-body file://udagram.yml \
  --parameters file://udagram-parameters.json \
  --capabilities CAPABILITY_NAMED_IAM || true

echo "Update commands submitted."
