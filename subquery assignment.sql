CREATE DATABASE assignment_company_db;
USE assignment_company_db ;
-- subqueries assignment 
-- Basic Level

-- question:1 Retrieve the names of employees who earn more than the average salary of all employees.
SELECT name
FROM employees
WHERE salary > (
    SELECT AVG(salary)
    FROM employees
);

-- question2 Find the employees who belong to the department with the highest average salary.
SELECT name
FROM employees
WHERE department_id = (
    SELECT department_id
    FROM employees
    GROUP BY department_id
    ORDER BY AVG(salary) DESC
    LIMIT 1
);


-- question3: List all employees who have made at least one sale.
SELECT name
FROM employees
WHERE emp_id IN (
    SELECT DISTINCT emp_id
    FROM sales
);


-- question4: Find the employee with the highest sale amount.
SELECT name
FROM employees
WHERE emp_id = (
    SELECT emp_id
    FROM sales
    WHERE sale_amount = (
        SELECT MAX(sale_amount)
        FROM sales
    )
);

-- question5: Retrieve the names of employees whose salaries are higher than Shubham’s salary.
SELECT name
FROM employees
WHERE salary > (
    SELECT salary
    FROM employees
    WHERE name = 'Shubham'
);



-- Intermediate Level

-- question6: Find employees who work in the same department as Abhishek.
SELECT name
FROM employees
WHERE department_id IN (
    SELECT department_id
    FROM employees
    WHERE name = 'Abhishek'
);

-- question7: List departments that have at least one employee earning more than ₹60,000.
SELECT department_name
FROM departments
WHERE department_id IN (
    SELECT department_id
    FROM employees
    WHERE salary > 60000
);

-- question8: Find the department name of the employee who made the highest sale.
SELECT 
    department_name
FROM
    departments
WHERE
    department_id = (SELECT 
            department_id
        FROM
            employees
        WHERE
            emp_id = (SELECT 
                    emp_id
                FROM
                    sales
                WHERE
                    sale_amount = (SELECT 
                            MAX(sale_amount)
                        FROM
                            sales)));

-- question9: Retrieve employees who have made sales greater than the average sale amount.
SELECT 
    name
FROM
    employees
WHERE
    emp_id IN (SELECT 
            emp_id
        FROM
            sales
        WHERE
            sale_amount > (SELECT 
                    AVG(sale_amount)
                FROM
                    sales));
                    
-- question10: Find the total sales made by employees who earn more than the average salary
SELECT SUM(sale_amount) AS total_sales
FROM sales
WHERE emp_id IN (
    SELECT emp_id
    FROM employees
    WHERE salary > (
        SELECT AVG(salary)
        FROM employees
    )
);

-- Advanced Level

-- question11: Find employees who have not made any sales
SELECT name
FROM employees e
WHERE NOT EXISTS (
    SELECT 1
    FROM sales s
    WHERE s.emp_id = e.emp_id
);

-- question12: List departments where the average salary is above ₹55,000.
SELECT department_name
FROM departments
WHERE department_id IN (
    SELECT department_id
    FROM employees
    GROUP BY department_id
    HAVING AVG(salary) > 55000
);

-- question13: Retrieve department names where the total sales exceed ₹10,000.
SELECT department_name
FROM departments
WHERE department_id IN (
    SELECT e.department_id
    FROM employees e
    JOIN sales s
      ON e.emp_id = s.emp_id
    GROUP BY e.department_id
    HAVING SUM(s.sale_amount) > 10000
);

-- question14: Find the employee who has made the second-highest sale.
SELECT name
FROM employees
WHERE emp_id = (
    SELECT emp_id
    FROM sales
    ORDER BY sale_amount DESC
    LIMIT 1, 1
);

-- question15: Retrieve the names of employees whose salary is greater than the highest sale amount recorded.
SELECT name
FROM employees
WHERE salary > (
    SELECT MAX(sale_amount)
    FROM sales
);




















   
   