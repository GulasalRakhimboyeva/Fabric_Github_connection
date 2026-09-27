# Fabric notebook source

# METADATA ********************

# META {
# META   "kernel_info": {
# META     "name": "synapse_pyspark"
# META   },
# META   "dependencies": {
# META     "lakehouse": {
# META       "default_lakehouse": "4b332dc2-1600-4b16-baad-9f12eeda4a7e",
# META       "default_lakehouse_name": "lakehouse3",
# META       "default_lakehouse_workspace_id": "f21e418a-2f11-4386-ad9c-0a175575df41",
# META       "known_lakehouses": [
# META         {
# META           "id": "4b332dc2-1600-4b16-baad-9f12eeda4a7e"
# META         }
# META       ]
# META     }
# META   }
# META }

# CELL ********************

from pyspark.sql.functions import lit, to_date, current_timestamp, col
df_initial = spark.read.option("header", True).csv("Files/customers_initial.csv")


# METADATA ********************

# META {
# META   "language": "python",
# META   "language_group": "synapse_pyspark"
# META }

# CELL ********************

df_scd = (df_initial
.withColumn("effective_from", to_date(col("last_updated")))
.withColumn("effective_to", lit("9999-12-31").cast("date"))
.withColumn("is_current", lit(True))
.withColumn("version", lit(1))
)

# METADATA ********************

# META {
# META   "language": "python",
# META   "language_group": "synapse_pyspark"
# META }

# CELL ********************

df_scd.write.format("delta").mode("overwrite").saveAsTable("dim_customer")
spark.read.table("dim_customer").show(5)

# METADATA ********************

# META {
# META   "language": "python",
# META   "language_group": "synapse_pyspark"
# META }

# CELL ********************

df_delta = spark.read.option("header", True).csv("Files/customers_delta.csv")

# METADATA ********************

# META {
# META   "language": "python",
# META   "language_group": "synapse_pyspark"
# META }

# CELL ********************

df_current = spark.read.table("dim_customer").filter(col("is_current") == True)
# Find customer_ids in delta that already exist with different attribute values
tracked_cols = ["city", "country", "loyalty_tier", "credit_limit"]
from functools import reduce
change_conditions = reduce(lambda a, b: a | b, [
(df_delta[c] != df_current[c]) for c in tracked_cols
])
df_changed_keys = (df_delta.alias("d")
.join(df_current.alias("c"), "customer_id", "inner")
.where(change_conditions)
.select("d.customer_id"))
df_changed_keys.show()

# METADATA ********************

# META {
# META   "language": "python",
# META   "language_group": "synapse_pyspark"
# META }

# CELL ********************

from delta.tables import DeltaTable
delta_dim = DeltaTable.forName(spark, "dim_customer")
delta_dim.alias("target").merge(
df_changed_keys.alias("src"),
"target.customer_id = src.customer_id AND target.is_current = true"
).whenMatchedUpdate(set={
"effective_to": "current_date() - interval 1 day",
"is_current": "false"
}).execute()

# METADATA ********************

# META {
# META   "language": "python",
# META   "language_group": "synapse_pyspark"
# META }

# CELL ********************

# All delta rows become new "current" rows
df_new_versions = (df_delta
.withColumn("effective_from", to_date(col("last_updated")))
.withColumn("effective_to", lit("9999-12-31").cast("date"))
.withColumn("is_current", lit(True))
.withColumn("version", lit(2))   # bump version
)
df_new_versions.write.format("delta").mode("append").saveAsTable("dim_customer")

# METADATA ********************

# META {
# META   "language": "python",
# META   "language_group": "synapse_pyspark"
# META }

# CELL ********************

spark.read.table("dim_customer") \
.filter(col("customer_id") == "C004") \
.select("loyalty_tier") \
.show(truncate=False)

# METADATA ********************

# META {
# META   "language": "python",
# META   "language_group": "synapse_pyspark"
# META }

# CELL ********************

spark.read.table("dim_customer") \
.filter((col("effective_from") <= '2025-06-05') & (col("effective_to") >= '2025-06-05')) \
.orderBy("customer_id")\
.select("loyalty_tier", "customer_id" )  \
.show(truncate=False)

# METADATA ********************

# META {
# META   "language": "python",
# META   "language_group": "synapse_pyspark"
# META }
