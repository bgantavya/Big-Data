# Setup Guide - Big Data Environment

This guide will help you set up your development environment for working with R, Hadoop, Spark, and SQL.

## 📋 Prerequisites

- **Operating System**: Linux (Ubuntu/Debian recommended) or macOS
- **RAM**: Minimum 8GB (16GB recommended for Spark/Hadoop)
- **Disk Space**: At least 20GB free space
- **Java**: JDK 8 or 11 (required for Hadoop and Spark)

## ☕ Install Java

```bash
# Ubuntu/Debian
sudo apt-get update
sudo apt-get install openjdk-11-jdk

# Verify installation
java -version

# Set JAVA_HOME
echo 'export JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64' >> ~/.bashrc
source ~/.bashrc
```

## 1️⃣ Install R

### Ubuntu/Debian
```bash
# Add CRAN repository
sudo apt-get update
sudo apt-get install -y software-properties-common
sudo add-apt-repository 'deb https://cloud.r-project.org/bin/linux/ubuntu focal-cran40/'

# Install R
sudo apt-get update
sudo apt-get install -y r-base r-base-dev

# Verify installation
R --version
```

### Install RStudio (Optional but Recommended)
```bash
# Download and install RStudio
wget https://download1.rstudio.org/desktop/bionic/amd64/rstudio-2023.12.0-369-amd64.deb
sudo dpkg -i rstudio-2023.12.0-369-amd64.deb
sudo apt-get install -f
```

### Install Essential R Packages
```r
# Start R console
R

# Install packages
install.packages(c(
  "tidyverse",   # Data manipulation and visualization
  "dplyr",       # Data manipulation
  "ggplot2",     # Data visualization
  "data.table",  # Fast data manipulation
  "sparklyr"     # R interface to Spark
))
```

## 2️⃣ Install Hadoop

### Download and Install
```bash
# Download Hadoop
cd /tmp
wget https://downloads.apache.org/hadoop/common/hadoop-3.3.6/hadoop-3.3.6.tar.gz

# Extract and move to /usr/local
tar -xzf hadoop-3.3.6.tar.gz
sudo mv hadoop-3.3.6 /usr/local/hadoop

# Set environment variables
cat >> ~/.bashrc << 'EOF'
export HADOOP_HOME=/usr/local/hadoop
export HADOOP_CONF_DIR=$HADOOP_HOME/etc/hadoop
export PATH=$PATH:$HADOOP_HOME/bin:$HADOOP_HOME/sbin
EOF

source ~/.bashrc
```

### Configure Hadoop (Pseudo-Distributed Mode)
```bash
# Edit hadoop-env.sh
echo 'export JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64' >> $HADOOP_HOME/etc/hadoop/hadoop-env.sh

# Configure core-site.xml
cat > $HADOOP_HOME/etc/hadoop/core-site.xml << 'EOF'
<?xml version="1.0"?>
<configuration>
  <property>
    <name>fs.defaultFS</name>
    <value>hdfs://localhost:9000</value>
  </property>
</configuration>
EOF

# Configure hdfs-site.xml
cat > $HADOOP_HOME/etc/hadoop/hdfs-site.xml << 'EOF'
<?xml version="1.0"?>
<configuration>
  <property>
    <name>dfs.replication</name>
    <value>1</value>
  </property>
</configuration>
EOF
```

### Start Hadoop
```bash
# Format namenode (only first time)
hdfs namenode -format

# Start HDFS
start-dfs.sh

# Verify
jps  # Should show NameNode, DataNode, SecondaryNameNode
hdfs dfs -ls /
```

## 3️⃣ Install Apache Spark

### Download and Install
```bash
# Download Spark
cd /tmp
wget https://downloads.apache.org/spark/spark-3.5.0/spark-3.5.0-bin-hadoop3.tgz

# Extract and move to /usr/local
tar -xzf spark-3.5.0-bin-hadoop3.tgz
sudo mv spark-3.5.0-bin-hadoop3 /usr/local/spark

# Set environment variables
cat >> ~/.bashrc << 'EOF'
export SPARK_HOME=/usr/local/spark
export PATH=$PATH:$SPARK_HOME/bin:$SPARK_HOME/sbin
export PYSPARK_PYTHON=python3
EOF

source ~/.bashrc
```

### Install PySpark
```bash
# Install pip if not already installed
sudo apt-get install python3-pip

# Install PySpark
pip3 install pyspark

# Verify installation
pyspark --version
```

### Test Spark
```bash
# Start Spark shell
spark-shell

# Or start PySpark
pyspark
```

## 4️⃣ Install SQL Database

### PostgreSQL
```bash
# Install PostgreSQL
sudo apt-get update
sudo apt-get install postgresql postgresql-contrib

# Start PostgreSQL
sudo service postgresql start

# Create user and database
sudo -u postgres createuser --interactive
sudo -u postgres createdb bigdata

# Access PostgreSQL
sudo -u postgres psql
```

### MySQL (Alternative)
```bash
# Install MySQL
sudo apt-get install mysql-server

# Secure installation
sudo mysql_secure_installation

# Start MySQL
sudo service mysql start

# Access MySQL
sudo mysql -u root -p
```

### DBeaver (Universal Database Tool)
```bash
# Download and install DBeaver
wget https://dbeaver.io/files/dbeaver-ce_latest_amd64.deb
sudo dpkg -i dbeaver-ce_latest_amd64.deb
sudo apt-get install -f
```

## 🧪 Verify Installation

### Test R
```bash
Rscript -e "print('R is working!')"
```

### Test Hadoop
```bash
hadoop version
hdfs dfs -ls /
```

### Test Spark
```bash
spark-submit --version
python3 -c "from pyspark.sql import SparkSession; print('PySpark is working!')"
```

### Test SQL
```bash
# PostgreSQL
psql --version

# MySQL
mysql --version
```

## 🐳 Docker Alternative (Recommended for Beginners)

If you want to avoid complex setup, use Docker:

```bash
# Install Docker
sudo apt-get update
sudo apt-get install docker.io docker-compose

# Start Hadoop
docker run -it sequenceiq/hadoop-docker:2.7.1 /etc/bootstrap.sh -bash

# Start Spark
docker run -it -p 8888:8888 jupyter/pyspark-notebook

# Start PostgreSQL
docker run --name postgres -e POSTGRES_PASSWORD=mysecretpassword -p 5432:5432 -d postgres
```

## 🎯 Quick Start Commands

```bash
# R
R                          # Start R console
Rscript script.R          # Run R script

# Hadoop
hdfs dfs -ls /            # List HDFS files
hadoop jar job.jar        # Run MapReduce job

# Spark
spark-shell               # Scala shell
pyspark                   # Python shell
spark-submit script.py    # Submit Spark job

# SQL
psql -U username -d dbname    # PostgreSQL
mysql -u username -p          # MySQL
```

## 📚 Next Steps

1. Navigate to each technology folder in this repository
2. Start with the `getting_started` files
3. Follow the examples and exercises
4. Check the RESOURCES.md file for additional learning materials

## ⚠️ Troubleshooting

### Common Issues

**Java not found**
```bash
# Make sure JAVA_HOME is set correctly
echo $JAVA_HOME
```

**Hadoop won't start**
```bash
# Check if ports are already in use
sudo lsof -i :9000
# Format namenode again
hdfs namenode -format
```

**Spark memory issues**
```bash
# Increase driver memory
spark-submit --driver-memory 4g script.py
```

**Permission denied**
```bash
# Make sure you have write permissions
sudo chown -R $USER:$USER /usr/local/hadoop
sudo chown -R $USER:$USER /usr/local/spark
```

## 🔗 Additional Resources

- [Official Hadoop Installation Guide](https://hadoop.apache.org/docs/stable/hadoop-project-dist/hadoop-common/SingleCluster.html)
- [Spark Getting Started](https://spark.apache.org/docs/latest/)
- [R Installation Guide](https://cran.r-project.org/)

---

*Happy Learning! If you encounter issues, check the troubleshooting section or open an issue.*
