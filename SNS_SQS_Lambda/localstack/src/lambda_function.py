import json

def lambda_handler(event, context):
    try:
        print("Received event: " + json.dumps(event, indent=2))

        for record in event['Records']:
            print("Message Body: " + record['body'])
        return {
            'statusCode': 200,
            'body': json.dumps('Hello from Lambda!')
        }
    except Exception as e:
        print("Error processing event: " + str(e))
        raise e