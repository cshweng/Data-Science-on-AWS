import time
import boto3
from botocore.config import Config
import requests
import json

my_config = Config(
        region_name = 'ap-east-1')

client = boto3.client('kinesis',config = my_config)

check = ""
for i in range (10):
    news = requests.get("https://newsapi.org/v2/everything?q="的"&searchIn=content&from=2023-01-01&sortBy=publishedAt&language=zh&apiKey=b3f8353c68774c509d840e2c4161e85e")
    news = news.json()["articles"][i]
    if check != news: 
        check = news
        print(news)
        response = client.put_record(StreamName='data-stream',
                                    Data = json.dumps(news),
                                     PartitionKey = "author")
    time.sleep(15)

