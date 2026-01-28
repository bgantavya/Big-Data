#!/bin/bash
# Hadoop HDFS Commands - Basic Operations
# This script demonstrates common HDFS commands

echo "==================================="
echo "Hadoop HDFS Basic Commands"
echo "==================================="

# NOTE: These commands require a running Hadoop cluster
# Uncomment and run commands as needed

echo -e "\n1. Check HDFS filesystem status"
# hdfs dfsadmin -report

echo -e "\n2. List files in HDFS root directory"
# hdfs dfs -ls /

echo -e "\n3. Create a directory in HDFS"
# hdfs dfs -mkdir -p /user/bigdata/input

echo -e "\n4. Upload a file to HDFS"
# echo "Hello, Big Data!" > sample.txt
# hdfs dfs -put sample.txt /user/bigdata/input/

echo -e "\n5. List contents of directory"
# hdfs dfs -ls /user/bigdata/input

echo -e "\n6. View file contents"
# hdfs dfs -cat /user/bigdata/input/sample.txt

echo -e "\n7. Download file from HDFS"
# hdfs dfs -get /user/bigdata/input/sample.txt ./downloaded_sample.txt

echo -e "\n8. Copy file within HDFS"
# hdfs dfs -cp /user/bigdata/input/sample.txt /user/bigdata/input/sample_copy.txt

echo -e "\n9. Move/Rename file in HDFS"
# hdfs dfs -mv /user/bigdata/input/sample_copy.txt /user/bigdata/input/sample_renamed.txt

echo -e "\n10. Remove file from HDFS"
# hdfs dfs -rm /user/bigdata/input/sample_renamed.txt

echo -e "\n11. Remove directory from HDFS (recursive)"
# hdfs dfs -rm -r /user/bigdata/output

echo -e "\n12. Check disk usage"
# hdfs dfs -du -h /user/bigdata

echo -e "\n13. Check file size"
# hdfs dfs -du -s -h /user/bigdata/input/sample.txt

echo -e "\n14. Change replication factor"
# hdfs dfs -setrep -w 3 /user/bigdata/input/sample.txt

echo -e "\n15. Get file information"
# hdfs dfs -stat "%n %o %r" /user/bigdata/input/sample.txt

echo -e "\n==================================="
echo "Uncomment commands to execute them"
echo "Make sure Hadoop is running first!"
echo "==================================="
