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
  --profile localstack \
  --endpoint-url http://localhost:4566
```

View Lambda logs:

```sh
docker logs localstack
```

## Test S3 Buckets on your browser

### Create Bucket

1. Go to Home and click Status Tab
2. On System Status, click S3. It should be "running".
3. On Buckets, click Create
4. On Bucket Details, input the followoing:
   1. ACL: Private
   2. Bucket: Your choice of bucket name. eg. localstacktest
      1. Bucket name should bne SND-compiant!
          - Must be lowercase.
          - Can only contain letters, numbers, dots (.), and hyphens (-).
          - Cannot contain underscores (_) or other special characters.
          - Must be between 3 and 63 characters long.
   3. Create Bucket Configuration
      1. Location Constraint: ap-northeast-1 (this is your default region)
5. Leave the rest of the field blank.

### Upload File

1. Download the index.html file under ./src
2. Click the bucket you have created
3. Click Upload


## Clean up

```sh
docker compose down
```