import json
import boto3
from botocore.config import Config
import base64

config = Config(region_name='ap-east-1')

def lambda_handler(event, context):
    records = event.get("Records")
    client = boto3.client('kinesis',config=config)
    curRecordSequenceNumber = []
    for record in records:
        sequenceNumber = record["kinesis"]["sequenceNumber"]
        data = base64.b64decode(record["kinesis"]["data"]).decode("utf-8") 
        curRecordSequenceNumber.append({'Data':json.dumps({'sequenceNumber':sequenceNumber,"data":json.loads(data)}),"PartitionKey":"part2"})
   # print(curRecordSequenceNumber)
    response = client.put_records(Records=curRecordSequenceNumber,StreamName="data-stream-2")
