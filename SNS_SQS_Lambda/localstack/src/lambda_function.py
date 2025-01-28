import json

def lambda_handler(event, context):
    print(event) # 受け取ったイベントを表示
    return {
        'statusCode': 200,
        'body': json.dumps('Hello from Lambda!')
    }
