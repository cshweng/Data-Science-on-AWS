from pymongo import MongoClient

# create a client instance to connect to the MongoDB server
client = MongoClient("mongodb://43.198.74.54:27017/?directConnection=true&serverSelectionTimeoutMS=2000&appName=mongosh+1.8.2")

# get the database object
db = client["mydatabase"]

# get the collection object
collection = db["mycollection"]

# retrieve all documents in the collection
results = collection.find()

# print the results
for result in results:
    print(result)