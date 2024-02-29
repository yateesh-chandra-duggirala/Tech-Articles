# Top 15 Advanced SQL Queries
As SQL is the most used tool for managing and analyzing the Relational Databases, We also its advanced techniques to enhance the ability to extract the valuable insights from the data. Let us look the 15 famous Techniques that every SQL Practitioner should know :

1. CTE (Common Table Expression) :
- CTEs provide a way to create a temporary Result sets that can be referenced within a query.
- They enhance readability and simplify complex queries. 
- Below is an example Query that helps us to understand CTE :
    ```
    WITH Job_of_Employee AS (
        SELECT job_id, count(*) as job_holders from employees
        group by job_id
        order by job_id
    )
    SELECT * from Job_of_Employee;
    ```

2. Window Functions : 
- Window functions allow for calculations across a set of rows related to the current row.
- Let us consider an example where we can calculate the maximum score over the departments, ()
    ```
    select distinct(dep_name), 
    max(score) OVER(PARTITION by dep_name) AS dep_max_score 
    from student_score;
    ```
- Consider an example that gives the rank() using order by as well:
    ```
    select employee_id, first_name, email, salary,
    RANK() OVER(ORDER BY salary desc) AS salary_rank
    from employees;
    ```

3. Recursive Functions :
- Recursive Queries enable traversal of hierarchial data structures like organizational charts or bill of materials.
- Suppose we have a table representing employee relationships, and we want to find all the subordinates of a given manager.
    ```
    WITH RECURSIVE subordinates AS (
        SELECT employee_id, first_name, manager_id
        FROM employees
        WHERE manager_id = 100
        UNION ALL 
        SELECT e.employee_id, e.first_name, e.manager_id
        FROM employees e JOIN subordinates s
        ON e.manager_id = s.employee_id
    )
    SELECT * FROM subordinates;
    ```

4. Pivot Function : 
- Pivot Tables transform rows into columns, summarizing data in a tabular format.
- Let us look at the example (SQL Server supports Pivot and Unpivot) :
    ```
    SELECT CustomerName, Laptop, Desktop from (
        SELECT * from Customers
    ) AS PivotData
    PIVOT (
        Sum(Amount) for ProductName IN (Laptop, Desktop)
    ) AS PivotTable;
    ```

5. UnPivot Function :
- UNPIVOT Operator is used when you want to convert the column-wise data into row-wise.
- Look at the below example for clear understanding : 
    ```
    SELECT AgentName, Country, SalesAmount
    FROM (
        SELECT * from ProductSales
    ) AS ActualData
    UNPIVOT(
        SalesAmount
        FOR Country IN (India, US, UK)
    ) AS UnPivotData
    ```

6. Analytical Functions:
- Analytic Functions compute aggregate values based on a group of rows.
- For example, we use the ROW_NUMBER() function to assign a unique row number to each record in a dataset : 
    ```
    select employee_id, department_id,
    ROW_NUMBER() over(order by department_id) AS department_rank
    from employees;
    ```

7. Conditional Aggregation : 
- Analytical Aggregation involves applying aggregate functions conditionally based in specific criteria.
- Let us calculate the average of the distributed sales : 
    ```
    select distributor_id, 
    AVG(CASE WHEN order_count > 1 THEN order_total ELSE NULL end) AS avg_distributor_sale
    FROM (
        SELECT distributor_id, count(*) as order_count, sum(quantity) AS order_total
        FROM sales_info
        GROUP by distributor_id
    ) AS distributor_orders
    GROUP BY distributor_id
    ```

8. Date Functions : 
- Date Functions in SQL allow manipulation and extraction of date-related information.
- For instance, We can use the DATE_TRUNC() function to group sales data by month (in Postgres):
    ```
    select to_char(DATE_TRUNC('month', date_of_sell), 'YYYY-Mon') AS month_, 
    SUM(quantity) AS total_sold
    from sales_info
    group by date_trunc('month', date_of_sell)
    order by month_
    ```

9. Merge Statement :
- Merge statements (also known as UPSERT or ON DUPLICATE KEY UPDATE) enable us to insert update or delete records in a target table based on the results of a join with a source table.
- Let us look at the below example from postgres : 
    ```
    MERGE INTO employee_info AS target
    USING(
        Values (110, 'John', 'john@gmail.com', '1997-09-17')
    ) AS source (employee_id, first_name, email, hire_date)
    ON (target.employee_id = source.employee_id)
    WHEN MATCHED THEN
        UPDATE SET first_name = source.first_name, email = source.email, hire_date = date(source.hire_date)
    WHEN NOT MATCHED THEN
        INSERT (employee_id, first_name, email, hire_date)
        VALUES(source.employee_id, source.first_name, source.email, date(source.hire_date));
    ```

10. Case Statements : 
- Case Statements allow for conditional logic within SQL Queries.
- For example, we can use case statement to categorise retailers accordingly
    ```
    select retailer_id, products_sold,
	CASE
		WHEN products_sold < 15 THEN 'Arcade'
		WHEN products_sold < 30 THEN 'Hero'
		ELSE 'SUPREME'
	END as title
    FROM (
        select retailer_id, sum(quantity) as products_sold
        from sales_info
        group by retailer_id
    ) AS retailer_rating;
    ```

11. String Functions : 
- String functions in SQL enable manipulation of text data.
- Let us look at an example, how we use the concat() function to concatenate strings.
    ```
    select employee_id, CONCAT(first_name,' ',last_name) as full_name
    from employees;
    ```

12. Grouping Sets :
- Grouping sets allow for the aggregation of data at multiple levels of granularity in a single query.
- Let us calculate the candidates that were hired by year and month.
    ```
    SELECT 
    EXTRACT(YEAR FROM hire_date) AS year_,
    EXTRACT(MONTH FROM hire_date) AS month_,
    COUNT(employee_id) AS employees_hired
    FROM 
    employees
    GROUP BY 
    GROUPING SETS (
        (EXTRACT(YEAR FROM hire_date), EXTRACT(MONTH FROM hire_date))
    )
    ORDER By year_ desc, month_;
    ```

13. Cross Joins :
- Cross joins produce the Cartesian Product of two tables, resulting in a combination of every row from each table.
- For example, We can use a cross join to generate all possible Combinations of products and customers.
    ```
    select s.distributor_id, s.retailer_id,
    i.item_code, i.item_desc
    from sales_info s 
    cross Join item i
    ```

14. Inline Views : 
- Inline views (also known as Derived tables) enable the creation of temporary result sets within a SQL Query.
- Let us say we want to find employees whose salary exceeding the average salary.
    ```
    select * from employees;
    select employee_id, salary
    FROM (
        SELECT employee_id, sum(salary) as salary
        FROM employees
        group by employee_id
    ) AS employee_salary
    where salary > (
        select avg(salary) from employees
    )
    ```

15. Set Operators : 
- Set Operators like UNION , INTERSECT and EXCEPT allow for combining the results of two or more queries.

- Union Example : 
    ```
    select employee_id, first_name, email, hire_date from employees
    UNION
    select employee_id, first_name, email, hire_date from employee_info
    order by employee_id;
    ```

- Intersect example :
    ```
    select employee_id, first_name, email, hire_date from employees
    INTERSECT
    select employee_id, first_name, email, hire_date from employee_info
    order by employee_id;
    ```

Mastering these queries help us in manipulating and analyzing data in a relational databases.