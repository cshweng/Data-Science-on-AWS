from pymongo import MongoClient

# 建立 MongoDB 連接
client = MongoClient("mongodb://43.198.74.54:27017/?directConnection=true&serverSelectionTimeoutMS=2000&appName=mongosh+1.8.2")

# Get the database
db = client['mydatabase']

# Create the collection
collection = db['mycollection']

# 插入一筆資料
result = collection.insert_one({"cshweng": "test"})

# 顯示插入資料的 ID
print(result.inserted_id)