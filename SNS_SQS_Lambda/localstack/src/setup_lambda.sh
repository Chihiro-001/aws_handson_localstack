#!/bin/bash

echo "Create Lambda function..."

# Create Lambda function
aws lambda create-function \
  --function-name process-sqs-messages \
  --runtime python3.12 \
  --role arn:aws:iam::000000000000:role/AWSLambdaSQSQueueExecutionRole \
  --handler lambda_function.lambda_handler \
  --zip-file fileb://function.zip \
  --endpoint-url http://localhost:4566 \
  --profile localstack

echo "Fetching the SQS queue ARN..."

QUEUE_ARN=$(aws sqs get-queue-attributes \
  --queue-url http://sqs.ap-northeast-1.localhost.localstack.cloud:4566/000000000000/localstack-handson \
  --attribute-names QueueArn \
  --endpoint-url http://localhost:4566 \
  --query Attributes.QueueArn \
  --output text \
  --profile localstack )
echo "QUEUE_ARN: $QUEUE_ARN"

echo "Create event source mapping..."

# Add SQS as a Lambda trigger
aws lambda create-event-source-mapping \
  --function-name process-sqs-messages \
  --event-source-arn "$QUEUE_ARN" \
  --endpoint-url http://localhost:4566 \
  --profile localstack