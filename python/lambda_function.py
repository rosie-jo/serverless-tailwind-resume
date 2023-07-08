import boto3
import json

def lambda_handler(event, context):
    client = boto3.client('dynamodb')
    table_name = 'terra_visitor_Counter'
    
    response = client.get_item(
        TableName=table_name,
        Key={
            'countID': {'S': '1'},
        }
    )
    
    if "Item" in response:
        # giving the visit count the value to begin from
        visit_count = int(response["Item"]["count"]["N"])

    # Increment visit count
    visit_count += 1
    
    # Update the new count in the table
    response = client.put_item(
        TableName=table_name,
        Item={
            "countID": {'S': '1'}, 
            "count": {'N': str(visit_count)}, 
        }
    )

    message = {
    "count": visit_count
    }
    return {
        'statusCode': 200,
        'headers': {'Content-Type': 'application/json'},
        'body': json.dumps(message)
    }


