#!/bin/bash
echo -e "Setting up LocalStack resources...\nCreating the /var/lib/localstack directory..."

mkdir -p /var/lib/localstack

echo "Creating resources in LocalStack..."

# Create SQS Standard queue
aws sqs create-queue \
  --queue-name localstack-handson \
  --endpoint-url "$LOCALSTACK_URL" \
  --region "$AWS_DEFAULT_REGION"

QUEUE_URL=$(aws sqs get-queue-url \
  --queue-name localstack-handson \
  --endpoint-url "$LOCALSTACK_URL" \
  --region "$AWS_DEFAULT_REGION" \
  --query QueueUrl \
  --output text)

echo "QUEUE_URL: $QUEUE_URL"

QUEUE_ARN=$(aws sqs get-queue-attributes \
  --queue-url "$QUEUE_URL" \
  --attribute-names QueueArn \
  --endpoint-url "$LOCALSTACK_URL" \
  --region "$AWS_DEFAULT_REGION" \
  --query Attributes.QueueArn \
  --output text)
echo "QUEUE_ARN: $QUEUE_ARN"

# Create SNS topic
SNS_TOPIC_ARN=$(aws sns create-topic \
  --name localstack-handson \
  --endpoint-url "$LOCALSTACK_URL" \
  --region "$AWS_DEFAULT_REGION" \
  --query TopicArn \
  --output text)

# Subscribe SQS to SNS
aws sns subscribe \
  --topic-arn "$SNS_TOPIC_ARN" \
  --protocol sqs \
  --notification-endpoint "$QUEUE_ARN" \
  --endpoint-url "$LOCALSTACK_URL" \
  --region "$AWS_DEFAULT_REGION"

# Create IAM role for Lambda
aws iam create-role \
  --role-name AWSLambdaSQSQueueExecutionRole \
  --assume-role-policy-document file:///usr/local/bin/trust_policy.json \
  --endpoint-url "$LOCALSTACK_URL"

# Create Lambda function
aws lambda create-function \
  --function-name process-sqs-messages \
  --runtime python3.12 \
  --role arn:aws:iam::000000000000:role/AWSLambdaSQSQueueExecutionRole \
  --handler lambda_function.lambda_handler \
  --zip-file fileb:///usr/local/bin/function.zip \
  --endpoint-url "$LOCALSTACK_URL"

# Add SQS as a Lambda trigger
aws lambda create-event-source-mapping \
  --function-name process-sqs-messages \
  --event-source-arn "$QUEUE_ARN" \
  --region "$AWS_DEFAULT_REGION" \
  --endpoint-url "$LOCALSTACK_URL"

echo "Resources setup complete!"
