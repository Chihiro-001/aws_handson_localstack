# HANDS-ON: SNS / SQS / Lambda

## Pre-Setup

```sh
zip localstack/src/function.zip localstack/src/lambda_function.py
```

## Setup

```sh
docker compose build

docker compose up
```

## Test Your Setup

Publish a message to SNS:

```sh
awslocal sns publish \
  --topic-arn ${SNS_TOPIC_ARN} \
  --message "Hello from SQS to Lambda #1"
```

Verify SQS receives the message:

```sh
awslocal list-queue

# Copy SQS QUEUE URL

awslocal sqs receive-message \
  --queue-url <SQS_QUEUE_URL>
```

View Lambda logs:

```sh
docker logs localstack
```
