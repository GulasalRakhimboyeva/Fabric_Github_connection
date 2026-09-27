# Fabric notebook source

# METADATA ********************

# META {
# META   "kernel_info": {
# META     "name": "synapse_pyspark"
# META   },
# META   "dependencies": {
# META     "lakehouse": {
# META       "default_lakehouse": "d068aa67-09ed-429c-bbd2-62d3e84428aa",
# META       "default_lakehouse_name": "reporting_lakehouse",
# META       "default_lakehouse_workspace_id": "f21e418a-2f11-4386-ad9c-0a175575df41",
# META       "known_lakehouses": [
# META         {
# META           "id": "d068aa67-09ed-429c-bbd2-62d3e84428aa"
# META         }
# META       ]
# META     }
# META   }
# META }

# CELL ********************

df_day1 = spark.read.option("header", True).csv("Files/sales_day1.csv")
df_day1 = df_day1.withColumn("sale_date", col("sale_date").cast("timestamp"))
df_day1.write.format("delta").mode("overwrite").saveAsTable("fact_sales")


# METADATA ********************

# META {
# META   "language": "python",
# META   "language_group": "synapse_pyspark"
# META }

# CELL ********************

from pyspark.sql.functions import lit, to_date, current_timestamp, col

# METADATA ********************

# META {
# META   "language": "python",
# META   "language_group": "synapse_pyspark"
# META }

# CELL ********************

max_date = df_day1.agg({"sale_date": "max"}).collect()[0][0]
from pyspark.sql import Row
control_df = spark.createDataFrame([
Row(table_name="fact_sales", last_loaded_timestamp=max_date)
])
control_df.write.format("delta").mode("overwrite").saveAsTable("load_control")
print(f"Day 1 watermark: {max_date}")

# METADATA ********************

# META {
# META   "language": "python",
# META   "language_group": "synapse_pyspark"
# META }

# CELL ********************

watermark = (spark.read.table("load_control")
.filter(col("table_name") == "fact_sales")
.select("last_loaded_timestamp")
.collect()[0][0])
print(f"Reading rows newer than {watermark}")

# METADATA ********************

# META {
# META   "language": "python",
# META   "language_group": "synapse_pyspark"
# META }

# CELL ********************

df_day2 = (spark.read.option("header", True).csv("Files/sales_day2.csv")
.withColumn("sale_date", col("sale_date").cast("timestamp"))
.filter(col("sale_date") > lit(new_max)))
print(f"New rows to load: {df_day2.count()}")

# METADATA ********************

# META {
# META   "language": "python",
# META   "language_group": "synapse_pyspark"
# META }

# CELL ********************

df_day2.write.format("delta").mode("append").saveAsTable("fact_sales")
new_max = df_day2.agg({"sale_date": "max"}).collect()[0][0]
spark.sql(f"""
UPDATE load_control
SET last_loaded_timestamp = '{new_max}'
WHERE table_name = 'fact_sales'
""")

# METADATA ********************

# META {
# META   "language": "python",
# META   "language_group": "synapse_pyspark"
# META }

# CELL ********************

spark.read.table("fact_sales").count()

# METADATA ********************

# META {
# META   "language": "python",
# META   "language_group": "synapse_pyspark"
# META }

# CELL ********************

spark.read.table("load_control").show()

# METADATA ********************

# META {
# META   "language": "python",
# META   "language_group": "synapse_pyspark"
# META }

# CELL ********************


# METADATA ********************

# META {
# META   "language": "python",
# META   "language_group": "synapse_pyspark"
# META }
