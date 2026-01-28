# Apache Spark

This directory contains Apache Spark exercises, applications, and notebooks for distributed data processing.

## 📋 Topics Covered

- Spark Core (RDDs, transformations, actions)
- Spark SQL and DataFrames
- Spark Streaming
- MLlib (Machine Learning)
- GraphX (Graph Processing)
- PySpark (Python API)
- Spark with Scala
- Performance tuning and optimization

## 📁 Structure

```
Spark/
├── core/            # Spark Core and RDD operations
├── sql/             # Spark SQL and DataFrame examples
├── streaming/       # Spark Streaming applications
├── mllib/           # Machine Learning with MLlib
├── graphx/          # Graph processing
├── pyspark/         # Python examples
├── scala/           # Scala examples
└── notebooks/       # Jupyter/Zeppelin notebooks
```

## 🔧 Setup

Install Spark:
```bash
# Download Spark
wget https://downloads.apache.org/spark/spark-3.5.0/spark-3.5.0-bin-hadoop3.tgz
tar -xzf spark-3.5.0-bin-hadoop3.tgz
mv spark-3.5.0-bin-hadoop3 /usr/local/spark

# Set environment variables
export SPARK_HOME=/usr/local/spark
export PATH=$PATH:$SPARK_HOME/bin:$SPARK_HOME/sbin
```

Install PySpark:
```bash
pip install pyspark
```

## 📚 Resources

- [Apache Spark Official Documentation](https://spark.apache.org/docs/latest/)
- [Learning Spark (O'Reilly)](https://www.oreilly.com/library/view/learning-spark-2nd/9781492050032/)
- [Spark by Examples](https://sparkbyexamples.com/)
- [PySpark Documentation](https://spark.apache.org/docs/latest/api/python/)

## 💡 Example (PySpark)

```python
from pyspark.sql import SparkSession

# Create Spark session
spark = SparkSession.builder \
    .appName("BigDataExample") \
    .getOrCreate()

# Read data
df = spark.read.csv("data.csv", header=True, inferSchema=True)

# Transform data
result = df.groupBy("category") \
    .agg({"value": "mean"}) \
    .orderBy("category")

# Show results
result.show()

# Stop Spark session
spark.stop()
```

## 💡 Example (Scala)

```scala
import org.apache.spark.sql.SparkSession

val spark = SparkSession.builder()
  .appName("BigDataExample")
  .getOrCreate()

val df = spark.read
  .option("header", "true")
  .csv("data.csv")

val result = df.groupBy("category")
  .agg(avg("value"))

result.show()
```

## 🚀 Running Spark

```bash
# Start Spark shell (Scala)
spark-shell

# Start PySpark shell
pyspark

# Submit a Spark application
spark-submit --master local[*] my_app.py
```
