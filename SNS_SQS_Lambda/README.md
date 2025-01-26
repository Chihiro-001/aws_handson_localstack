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
  --topic-arn arn:aws:sns:ap-northeast-1:000000000000:localstack-handson \
  --message "Hello from SQS to Lambda #1"
```

Verify SQS receives the message:

```sh
awslocal sqs list-queues

# Copy SQS QUEUE URL

awslocal sqs receive-message \
  --queue-url <SQS_QUEUE_URL>
```

View Lambda logs:

```sh
docker logs localstack
```
