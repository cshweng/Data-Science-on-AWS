import websocket
import boto3 
from botocore.config import Config
import json

my_config = Config(
    region_name = 'ap-east-1')

client = boto3.client('kinesis',config=my_config)

def on_message(wsapp, message):
    record = {"id":"test","data":message}
    record = json.dumps(record)
    response = client.put_record(StreamName='data-stream',Data=str(record),PartitionKey='ws')
    print(record)

def on_open(wsapp):
    wsapp.send('{"subscribe":["ETH-USD","USDT-USD","USDC-USD","BNB-USD","ADA-USD","BUSD-USD","XRP-USD"]}')

wsapp = websocket.WebSocketApp("wss://streamer.finance.yahoo.com/",on_open=on_open,on_message=on_message)
wsapp.run_forever() 

