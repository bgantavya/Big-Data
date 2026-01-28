-- SQL Basics - Getting Started
-- This file contains basic SQL queries for learning

-- 1. CREATE TABLE
-- Create a sample employees table
CREATE TABLE IF NOT EXISTS employees (
    employee_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    department VARCHAR(50),
    salary DECIMAL(10, 2),
    hire_date DATE
);

-- 2. INSERT DATA
-- Insert sample data
INSERT INTO employees (first_name, last_name, department, salary, hire_date) VALUES
    ('John', 'Doe', 'Engineering', 75000.00, '2020-01-15'),
    ('Jane', 'Smith', 'Marketing', 65000.00, '2019-03-20'),
    ('Mike', 'Johnson', 'Engineering', 80000.00, '2018-07-10'),
    ('Emily', 'Brown', 'Sales', 70000.00, '2021-05-12'),
    ('David', 'Wilson', 'Engineering', 85000.00, '2017-09-01'),
    ('Sarah', 'Taylor', 'Marketing', 60000.00, '2022-02-14');

-- 3. SELECT - Basic Queries
-- Select all columns
SELECT * FROM employees;

-- Select specific columns
SELECT first_name, last_name, department FROM employees;

-- Select with WHERE clause
SELECT first_name, last_name, salary 
FROM employees 
WHERE department = 'Engineering';

-- 4. FILTERING
-- Find employees with salary > 70000
SELECT first_name, last_name, salary
FROM employees
WHERE salary > 70000;

-- Find employees hired after 2020
SELECT first_name, last_name, hire_date
FROM employees
WHERE hire_date > '2020-01-01';

-- 5. SORTING
-- Sort by salary descending
SELECT first_name, last_name, salary
FROM employees
ORDER BY salary DESC;

-- Sort by department and salary
SELECT first_name, last_name, department, salary
FROM employees
ORDER BY department, salary DESC;

-- 6. AGGREGATION
-- Count employees by department
SELECT department, COUNT(*) as employee_count
FROM employees
GROUP BY department;

-- Average salary by department
SELECT department, 
       AVG(salary) as avg_salary,
       MIN(salary) as min_salary,
       MAX(salary) as max_salary
FROM employees
GROUP BY department;

-- 7. HAVING clause
-- Departments with more than 1 employee
SELECT department, COUNT(*) as employee_count
FROM employees
GROUP BY department
HAVING COUNT(*) > 1;

-- 8. UPDATE
-- Update salary for an employee
-- UPDATE employees SET salary = 78000.00 WHERE employee_id = 1;

-- 9. DELETE
-- Delete an employee (commented out for safety)
-- DELETE FROM employees WHERE employee_id = 10;

-- 10. USEFUL QUERIES
-- Total payroll
SELECT SUM(salary) as total_payroll FROM employees;

-- Most recently hired employee
SELECT first_name, last_name, hire_date
FROM employees
ORDER BY hire_date DESC
LIMIT 1;
