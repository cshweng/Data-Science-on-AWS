
from pyspark import SparkContext
from pyspark.sql import SparkSession
from pyspark.sql.types import StringType, DateType, FloatType,TimestampType, IntegerType
from pyspark.sql.types import ArrayType, DoubleType, LongType, StringType, StructType, StructField
from pyspark.sql.functions import year, month, dayofmonth, hour
from pyspark.sql.functions import *

sc = SparkContext().getOrCreate()
spark = SparkSession(sc)


df = spark.read \
    .format("jdbc") \
    .option("url", "jdbc:sqlserver://database-1.cody2fe6kgml.us-east-1.rds.amazonaws.com:1433;databaseName=Jay-test") \
    .option("dbtable", "claim") \
    .option("user", "admin") \
    .option("password", "XXXXX") \
    .load()
    
df = df.withColumn('Date', split(df['issue_date'], ' ').getItem(0))
df = df.withColumn('Month', split(df['Date'], '/').getItem(1))
df.printSchema()

glue_database_name = 'testglue'
glue_table_name = 'jay_test_dbo_claim'

s3_target_path = 's3://jay-send-box/jay_test_dbo_claim/'

df.show()



partition_columns = ['month']
df.write \
    .option('path',s3_target_path) \
    .partitionBy(partition_columns) \
    .mode('append') \
    .format('parquet') \
    .saveAsTable('default.jay_test_dbo_claim') 
    
