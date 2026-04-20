#!/bin/bash
set -e

REGION=us-east-1
NETWORK_STACK=udagram-network
APP_STACK=udagram-app

echo "Creating network stack..."
aws cloudformation create-stack \
  --region $REGION \
  --stack-name $NETWORK_STACK \
  --template-body file://network.yml \
  --parameters file://network-parameters.json \
  --capabilities CAPABILITY_NAMED_IAM

aws cloudformation wait stack-create-complete \
  --region $REGION \
  --stack-name $NETWORK_STACK

echo "Creating application stack..."
aws cloudformation create-stack \
  --region $REGION \
  --stack-name $APP_STACK \
  --template-body file://udagram.yml \
  --parameters file://udagram-parameters.json \
  --capabilities CAPABILITY_NAMED_IAM

aws cloudformation wait stack-create-complete \
  --region $REGION \
  --stack-name $APP_STACK

echo "Done."
aws cloudformation describe-stacks \
  --region $REGION \
  --stack-name $APP_STACK \
  --query "Stacks[0].Outputs"
