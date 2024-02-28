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