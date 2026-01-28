#!/bin/bash
# Run WordCount MapReduce Job
# This script demonstrates how to run a Hadoop Streaming job

echo "==================================="
echo "Hadoop MapReduce WordCount Example"
echo "==================================="

# Make mapper and reducer executable
chmod +x wordcount_mapper.py
chmod +x wordcount_reducer.py

# Test locally before running on Hadoop
echo -e "\n--- Testing Locally ---"
echo "This is a test file for wordcount" | python3 wordcount_mapper.py | sort | python3 wordcount_reducer.py

# To run on Hadoop (uncomment and modify paths as needed):
# 
# INPUT_DIR="/user/bigdata/input"
# OUTPUT_DIR="/user/bigdata/output/wordcount"
#
# # Remove output directory if it exists
# hdfs dfs -rm -r $OUTPUT_DIR 2>/dev/null
#
# # Run Hadoop Streaming job
# hadoop jar $HADOOP_HOME/share/hadoop/tools/lib/hadoop-streaming-*.jar \
#     -input $INPUT_DIR \
#     -output $OUTPUT_DIR \
#     -mapper wordcount_mapper.py \
#     -reducer wordcount_reducer.py \
#     -file wordcount_mapper.py \
#     -file wordcount_reducer.py
#
# # View results
# hdfs dfs -cat $OUTPUT_DIR/part-* | head -20

echo -e "\n==================================="
echo "Uncomment Hadoop commands to run on cluster"
echo "==================================="
