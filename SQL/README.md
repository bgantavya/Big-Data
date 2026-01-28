# SQL (Structured Query Language)

This directory contains SQL queries, database exercises, and data manipulation scripts for Big Data applications.

## 📋 Topics Covered

- SQL fundamentals (SELECT, INSERT, UPDATE, DELETE)
- Joins and subqueries
- Aggregation and grouping
- Window functions
- Indexes and optimization
- Database design and normalization
- Stored procedures and functions
- NoSQL databases (optional)
- SQL for Big Data (Hive, Impala, Presto)

## 📁 Structure

```
SQL/
├── basics/          # Fundamental SQL queries
├── joins/           # JOIN operations and examples
├── aggregation/     # GROUP BY, aggregate functions
├── advanced/        # Window functions, CTEs, complex queries
├── optimization/    # Query optimization and indexing
├── ddl/             # Data Definition Language (CREATE, ALTER, DROP)
├── dml/             # Data Manipulation Language (INSERT, UPDATE, DELETE)
├── big-data/        # Hive, Impala, Presto queries
└── sample-data/     # Sample datasets for practice
```

## 🔧 Setup

Install PostgreSQL (example):
```bash
# On Ubuntu/Debian
sudo apt-get update
sudo apt-get install postgresql postgresql-contrib

# Start PostgreSQL service
sudo service postgresql start

# Access PostgreSQL
sudo -u postgres psql
```

Install MySQL (alternative):
```bash
# On Ubuntu/Debian
sudo apt-get install mysql-server
sudo mysql_secure_installation
```

## 📚 Resources

- [PostgreSQL Documentation](https://www.postgresql.org/docs/)
- [MySQL Documentation](https://dev.mysql.com/doc/)
- [SQL Tutorial - W3Schools](https://www.w3schools.com/sql/)
- [Mode Analytics SQL Tutorial](https://mode.com/sql-tutorial/)
- [Apache Hive](https://hive.apache.org/)

## 💡 Example Queries

### Basic SELECT
```sql
SELECT customer_name, order_date, total_amount
FROM orders
WHERE order_date >= '2024-01-01'
ORDER BY total_amount DESC;
```

### JOIN Example
```sql
SELECT 
    c.customer_name,
    o.order_id,
    p.product_name,
    oi.quantity
FROM customers c
INNER JOIN orders o ON c.customer_id = o.customer_id
INNER JOIN order_items oi ON o.order_id = oi.order_id
INNER JOIN products p ON oi.product_id = p.product_id;
```

### Aggregation
```sql
SELECT 
    category,
    COUNT(*) as product_count,
    AVG(price) as avg_price,
    MAX(price) as max_price
FROM products
GROUP BY category
HAVING COUNT(*) > 5;
```

### Window Function
```sql
SELECT 
    employee_name,
    department,
    salary,
    RANK() OVER (PARTITION BY department ORDER BY salary DESC) as salary_rank
FROM employees;
```

## 🎯 Practice Datasets

Common datasets for practice:
- Northwind database
- Adventure Works
- Sakila (DVD rental)
- Chinook (music store)

## 🔗 Big Data SQL

### Hive Example
```sql
-- Create external table
CREATE EXTERNAL TABLE IF NOT EXISTS sales (
    sale_id INT,
    product_id INT,
    quantity INT,
    price DECIMAL(10,2)
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
STORED AS TEXTFILE
LOCATION '/user/hive/warehouse/sales';

-- Query with Hive
SELECT product_id, SUM(quantity * price) as total_revenue
FROM sales
GROUP BY product_id
ORDER BY total_revenue DESC
LIMIT 10;
```
