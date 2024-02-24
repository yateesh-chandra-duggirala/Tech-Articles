# SQL Interview Patterns for Data Engineers
    Familiarity with many of the SQL patterns ensures Data Engineers can handle not just common tasks but also intricate and unexpected challenges that might arise in real-world data Engineering Roles.

## Understanding CTEs and Rolling Windows:
- A common Table Expression(CTE) is a temporary  result set that you can refer to within a SELECT, INSERT, UPDATE, DELETE statement.
- It provides better readability and can be thought of as defining a temporary view for just one query.
- When used in combination with BETWEEN, It also can be used to create rolling windows.
- In the given  SQL, We are attempting to calculate the average daily active users over a rolling Window of 3 days :

WITH cte_dau AS (
  SELECT 
    event_date AS day,
    COUNT(DISTINCT userid) as dau
  FROM user_activity_log
  GROUP BY event_date
  ORDER BY 1
)
SELECT 
  a.day,
  AVG(b.dau) AS "3_day_dau_avg"
FROM cte_dau a
INNER JOIN cte_dau b
  ON b.day BETWEEN a.day - INTERVAL '3' DAY AND a.day
GROUP BY a.day
ORDER BY a.day;

The BreakDown :
1. CTE Definition('cte_dau'):
- The CTE(cte_dau) selects the event_date as the 'day' and calculates the distinct count of userid as dau(daily active users) for each day.
- This is a simple aggregation of how many unique users were active each day from the user_activity_log table.

2. Using the CTE:
- Now that we have our CTE, we are doing a self join it. We alias these as a and b
- The Inner Join condition with BETWEEN is crucial. For each day in 'a' we are looking for rows in b that fall within a 3-day window including and preceding the day in a.
- The Function DATEADD(day, -3, a.dy) is used to get the starting day of our 3-day window for each day in a. The BETWEEN condition ensures that for each day in a, we are considering that day and the previous 2 days from b

3. Calculating the Rolling Average:
- The AVG(b.dau) computes the average DAU over the rolling window.
- The GROUP BY ensures we are calculating this average for each distinct day.

4. OUTPUT :
- The final result shows the day and the corresponding 3-day average DAU for that day.
- In essence, for each day, this SQL Provides the average of daily active users for that day and the two preceding days, giving a rolling average.

## Understanding How to use SUM with CASE :
- Using SUM with a CASE Statement allows you to create conditional aggregations.
- Essential, you are telling the SQL Engine to sum up values only when certain conditions are met.
- The aim is to calculate the percentage of sales that happened on the first and last day of promotion.

SELECT ROUND(Sum(
  CASE WHEN Min(start_date) = transaction_date THEN 1
       WHEN Max(end_date) = transaction_date THEN 1
       ELSE 0
  END) 100 / Count(), 2)
FROM sales s
JOIN promotions p
ON s.promotion_id = p.promotion_id;

The Breakdown:
1. The CASE Statement :
- The CASE statement checks each transaction's date.
- When Min(start_date) = transaction_date THEN 1 : This checks if the transaction date is the same as the start date of the promotion. If true, it returns 1.
- Else 0 : If neither of the above conditions are met, it returns 0.
- The result of the CASE statement is that each transaction on the first or last day of the promotion is counted as 1, and all other transaction are counted as 0.

2. SUM and COUNT : 
- SUM(CASE ... END) will sum up all the 1s and 0s from the CASE statement.
- This gives the total number of transactions on the first and last days.
- Count() will count all transactions irrespective of their date, giving the total number of transactions.

3. Percentage Calculation :
- The calculated sum(from the CASE statement) is then multiplied by 100 and divided by the count of all transactions.
- This gives the percentage of transactions that happened on the first and last days.

4. ROUND :
- The Round(..., 2) function ensures the percentage is rounded to 2 decimal places for a cleaner output.

5. FROM and Join :
- The data is sourced from the sales table and joined with the promotions table on promotion_id.

## Using SUM with a CASE Statement for the numerator :
- The combination of SUM with a CASE statement and COUNT(*) is frequently used in SQL for deriving proportions or percentages based on specific criteria.
- We can use this pattern to solve a problem such as What is the proportion of valid sales that occured on Jan 1 2021. 

SELECT
SUM(CASE WHEN transaction_date = '2021-01-01' THEN 1 ELSE 0 END)
/
COUNT(*) AS proportion
FROM sales
WHERE is_valid = true;

1. The CASE Statement :
- The case statement inspects each row's transaction_date.
- WHEN transaction_date = '2021-01-01' THEN 1 : This checks if the the transaction_date is the specified date. If it is true, it returns 1, otherwise nothing is returned (implicitly null).
- By summing up that result of this case statement, we obtain a total count of transactions that occured on the specified date.

2. Using Count(*) for the denominator:
- Count(*) counts all rows in the result set. Since the query is already filtered by the WHERE clause to only valid sales, this count will give us the total number of valid sales, regardless of their date.

3. Calculating the Proportion :
- The numerator is divided by the denominator. This gives the proportion of valid sales that happened on the specified date.

4. The WHERE Clause :
- The Where filter limits both the numerator and denominator to rows where the sale is valid using WHERE is_valid = true.

## Complex Ordering of Aggregates :
- SQL allows users to perform complex sorting by using aggregate functions combined with arithmetic operations in the order by clause. Let us break down an example query and understand how this works. We wants to identify the top 3 product_class_ids based on the total sales value.

SELECT product_class_id
FROM product
JOIN sales ON product.product_id = sales.product_id
ORDER BY SUM(units * store_cost) DESC
LIMIT 3;

1. Join Operation:
- The Query Performs an inner join between the product and sales tables based on a common column, persumably product_id

2. Calculating Sales Value for each Product :
- Within the order By Clause, the product's units from the sales table is multiplied by the store_cost from the same or another table. 
- This gives the total sales value for each product in the dataset.

3. Ordering Using Aggregates Function :
- The sum(units * store_cost) part aggregates (sums up) the total sales value for each product_class_id.
- The ORDER BY ... DESC sorts the product_class_id based on this aggregated sales value in descending order, so that product_class_id with the highest sales value will appear first.

4. Limiting Results :
- Finally the Limit 3 ensures that only the top 3 rows are returned.

The beauty of using ORDER BY with aggregate and arithmetic operations like in this query is that enables complex sorting criteria. Rather than just sorting by a single column, you can create custom sorting metrics based on the data's properties and your business requirements.