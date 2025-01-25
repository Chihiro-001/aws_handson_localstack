#!/bin/bash

until awslocal sqs list-queues > /dev/null 2>&1; do
  echo "Waiting for LocalStack to start..."
  sleep 5
done

echo "Creating resources in LocalStack..."

# Create SQS Standard queue
awslocal sqs create-queue --queue-name localstack-handson

# Create SNS topic
awslocal sns create-topic --name localstack-handson

# Subscribe SQS to SNS
awslocal sns subscribe \
  --topic-arn ${SNS_TOPIC_ARN} \
  --protocol sqs \
  --notification-endpoint ${SNS_NOTIFICATION_ENDPOINT}

# Create IAM role for Lambda
awslocal iam create-role --role-name AWSLambdaSQSQueueExecutionRole \
  --assume-role-policy-document file:///etc/localstack/init/ready.d/trust-policy.json

# Create Lambda function
awslocal lambda create-function \
  --function-name process-sqs-messages \
  --runtime python3.12 \
  --role arn:aws:iam::000000000000:role/AWSLambdaSQSQueueExecutionRole \
  --handler lambda_function.lambda_handler \
  --zip-file fileb:///etc/localstack/init/ready.d/function.zip

# Add SQS as a Lambda trigger
awslocal lambda create-event-source-mapping \
  --function-name process-sqs-messages \
  --event-source-arn ${SQS_ARN}

echo "Resources setup complete!"
