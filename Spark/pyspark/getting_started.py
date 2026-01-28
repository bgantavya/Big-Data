#!/usr/bin/env python3
"""
PySpark Example - Getting Started with Spark
This script demonstrates basic PySpark operations
"""

from pyspark.sql import SparkSession
from pyspark.sql.functions import col, avg, count, sum as spark_sum

def main():
    # Create Spark Session
    spark = SparkSession.builder \
        .appName("BigData-PySpark-Example") \
        .master("local[*]") \
        .getOrCreate()
    
    print("=" * 50)
    print("PySpark Example - Getting Started")
    print("=" * 50)
    
    # Create a sample dataset
    data = [
        ("Alice", "Engineering", 75000),
        ("Bob", "Marketing", 65000),
        ("Charlie", "Engineering", 80000),
        ("David", "Sales", 70000),
        ("Eve", "Engineering", 85000),
        ("Frank", "Marketing", 60000)
    ]
    
    # Create DataFrame
    columns = ["Name", "Department", "Salary"]
    df = spark.createDataFrame(data, columns)
    
    print("\n1. Sample Data:")
    df.show()
    
    # Basic operations
    print("\n2. Schema:")
    df.printSchema()
    
    # Filtering
    print("\n3. Engineering Department Employees:")
    df.filter(col("Department") == "Engineering").show()
    
    # Aggregation
    print("\n4. Average Salary by Department:")
    df.groupBy("Department") \
        .agg(avg("Salary").alias("AvgSalary"),
             count("Name").alias("Count")) \
        .show()
    
    # Sorting
    print("\n5. Top Earners:")
    df.orderBy(col("Salary").desc()).show(3)
    
    # SQL Query
    df.createOrReplaceTempView("employees")
    print("\n6. SQL Query Result:")
    spark.sql("""
        SELECT Department, 
               COUNT(*) as EmployeeCount,
               AVG(Salary) as AvgSalary
        FROM employees
        GROUP BY Department
        ORDER BY AvgSalary DESC
    """).show()
    
    # Stop Spark session
    spark.stop()
    print("\nSpark session stopped.")

if __name__ == "__main__":
    main()
