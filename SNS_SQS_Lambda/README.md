# HANDS-ON: SNS / SQS / Lambda

This is a hands-on resources to learn LocalStack. 

The hands-on content is referenced from here: [AWS Hands-on SNS/SQS/Lambda](https://dcj71ciaiav4i.cloudfront.net/49D0D220-8D0F-11EB-8F39-FD9A62BABEEC/chapter3.html)

## Pre-Setup

Zip your lambda function:

```sh
zip localstack/src/function.zip localstack/src/lambda_function.py
```

## Setup

Build and run your Docker container:

```sh
docker compose build

docker compose up
```

## Test Your Setup

Publish a message to SNS:

```sh
aws sns publish \
  --topic-arn arn:aws:sns:ap-northeast-1:000000000000:localstack-handson \
  --message "Hello from SNS #1" \
  --profile localhost \
  --endpoint-url http://localhost:4566
```

View Lambda logs:

```sh
docker logs localstack
```
