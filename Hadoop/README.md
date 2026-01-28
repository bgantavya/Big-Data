# Hadoop

This directory contains Hadoop-related exercises, MapReduce programs, and HDFS operations.

## 📋 Topics Covered

- HDFS (Hadoop Distributed File System)
- MapReduce programming
- YARN (Yet Another Resource Negotiator)
- Hadoop ecosystem tools (Hive, Pig, HBase)
- Hadoop configuration and administration
- Data ingestion and processing pipelines

## 📁 Structure

```
Hadoop/
├── hdfs/         # HDFS commands and operations
├── mapreduce/    # MapReduce programs (Java, Python)
├── hive/         # Hive queries and scripts
├── pig/          # Pig Latin scripts
├── hbase/        # HBase examples
└── config/       # Configuration files and setup guides
```

## 🔧 Setup

Install Hadoop (Single Node):
```bash
# Download Hadoop
wget https://downloads.apache.org/hadoop/common/hadoop-3.3.6/hadoop-3.3.6.tar.gz
tar -xzf hadoop-3.3.6.tar.gz
mv hadoop-3.3.6 /usr/local/hadoop

# Set environment variables
export HADOOP_HOME=/usr/local/hadoop
export PATH=$PATH:$HADOOP_HOME/bin:$HADOOP_HOME/sbin
```

## 📚 Resources

- [Apache Hadoop Official Documentation](https://hadoop.apache.org/docs/)
- [Hadoop: The Definitive Guide](https://www.oreilly.com/library/view/hadoop-the-definitive/9781491901687/)
- [Hadoop Tutorials](https://hadoop.apache.org/docs/current/hadoop-mapreduce-client/hadoop-mapreduce-client-core/MapReduceTutorial.html)

## 💡 Example

```bash
# HDFS Commands
hdfs dfs -ls /
hdfs dfs -mkdir /user/data
hdfs dfs -put local_file.txt /user/data/

# Run MapReduce job
hadoop jar hadoop-mapreduce-examples.jar wordcount /input /output
```

## 🎯 WordCount Example

Classic MapReduce WordCount in Java:
```java
// Mapper
public static class TokenizerMapper extends Mapper<Object, Text, Text, IntWritable> {
    private final static IntWritable one = new IntWritable(1);
    private Text word = new Text();
    
    public void map(Object key, Text value, Context context) {
        StringTokenizer itr = new StringTokenizer(value.toString());
        while (itr.hasMoreTokens()) {
            word.set(itr.nextToken());
            context.write(word, one);
        }
    }
}
```
