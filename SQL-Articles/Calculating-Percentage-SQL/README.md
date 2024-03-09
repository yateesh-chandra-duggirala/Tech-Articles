# Calculating Percentages with Code Examples :
- SQL is a powerful tool for managing and analyzing data stored in relational databases. 
- One common task in data analysis is calculating percentages, which can provide valuable insights into the distribution of data. 
- In this article, we'll explore how to calculate percentages using SQL with practical code examples.

## Calculating Percentages :
1. Let's calculate the percentage contribution of each item_id to total number of items.

    ```
    select item_id, sum(quantity) as qty,
    round(( sum(quantity) * 100.00 / (select sum(quantity) from order_items)), 3) as percentage
    from order_items
    group by item_id
    order by sum(quantity) desc;
    ```

2. Let's calculate the percentage contribution of various states.

    ```
    select state, count(state),
    round((count(state) * 100.00 / (select count(state) from customers)), 3) as percentage
    from customers
    group by state
    order by state desc
    ```

## Grouped Percentages :
- Calculating percentages within groups is also common in data analysis. 
- Let's say we want to find the percentage for each order_status.
    ```
    SELECT order_status,
       count(order_status) AS total_sales,
       (count(order_status) * 100.00 / SUM(count(order_status)) OVER ())  AS percentage
    FROM orders
    GROUP BY order_status;
    ```

## Filtering the percentages :
- Let us filter products that contribute more than 20% of items .

    ```
    select item_id, sum(quantity) as qty,
    round(( sum(quantity) * 100.00 / (select sum(quantity) from order_items)), 3) as percentage
    from order_items
    group by item_id
    having (sum(quantity) * 100.00 / (select sum(quantity) from order_items)) > 20
    order by sum(quantity) desc;
    ```

## Conclusion :
- Calculating percentages in SQL is a valuable skill for data analysts and database professionals. 
- It allows you to gain insights into data distributions and make informed decisions based on proportions. 
- Whether you're analyzing sales data, survey responses, or any other dataset, SQL provides the tools to perform these calculations efficiently.
