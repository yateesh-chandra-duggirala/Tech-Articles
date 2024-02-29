# 10 SQL Best SQL Practices 
- Writing clear, logical, easy-to-read and high performance ETL pipelines in SQL, is an important part of a data scientist's day to day job.
- The benefits of following the SQL Styles practices include :
    a. Improved Code Readability
    b. Reduced Ambiguity,
    c. Enhanced deugging efficiency,
    d. Optimized Code Performance

## Rule 1 :
- Keywords and function names should be all lowercase
- Lower case are much easier for humans to read.
    ```
    /* Good */
    select *
    from customers

    /* Bad */
    SELECT *
    FROM customers
    ```

## Rule 2 : 
- Use select distinct instead of grouping by all columns.
- This makes the intention clear
    ```
    /* Good */
    select distinct
        customer_id
        , date_trunc('day', created_at) as purchase_date
    from orders

    /* Bad */
    select customer_id
    , date_trunc('day', created_at) as purchase_date
    from orders
    group by 1, 2
    ```

## Rule 3 : 
- Use Union All instead of Union unless duplicate rows really do need to be removed.
- Union All is more performant because it does not have to sort and de-duplicate rows.

## Rule 4 :
- Where performances permits, CTEs should perform a single, logical unit of work.
- CTE Names should be as verbose as needed to convey what they do.
- CTE names should not be suffixed or prefixed with 'cte'. 
- CTEs with confusing or notable logic should be commented.

## Rule 5:
- Use CTEs rather than subqueries.
- CTEs will make the queries more straight forward to read or reason about can be referenced multiple times and are easier to adapt/ refactor later.

## Rule 6:
- name single column primary keys id.
- This allows us to easily tell at a glance whether a column is a primary key, helps us discern whether joins are one-to-many or many-to-one, and is more succint than other primary key naming conventions (Particularly in join conditions).
    ```
    /* Good */
    select * 
    from order
    left join customers on orders.customer_id = customers.id
    /* Easier to tell this is a many to one join and thus will not fan out.*/

    /* Bad */
    select *
    from orders
    left join customers on orders.customer_id = customers.customer_id
    ```

## Rule 7 :
- Use Leading commas.
- If code containing commas need to be split across multiple lines, put the commas at the beginning of the subsequent lines, followed by a space.
- During debugging, you can comment on/ off the whole line without causing error such as "nothing followed the comma it would not be needed".
- This makes it easier to spot missing commas.
- Version control diff will be cleaner when adding to the end of a list because you do not have to add a trailing comma to the preceding line.
    ```
    /* Good */
    select 
        id
        , email
        , date_trunc('month', created_at) as signup_month
    from paying_customers
    
    /* Bad */
    select 
        id, 
        email,
        date_trunc('month', created_at) as signup_month
    from paying_customers
    ```

## Rule 8 :
- Use Single Quotes for strings.
- Some SQL dialects like BigQuery support using double quotes or even triple quotes for strings, but for most dialects, Double Quoted Strings represent identifiers.
- Triple Quoted Strings will be interpreted like the value itself contains leading and trailing single quotes.
    ```
    /* Good */
    select *
    from customers
    where email like '%@domain.com'

    /* Bad */
    select *
    from customers
    where email like "%@domain.com"    
    /* will result in an error like column not exist*/
    ```

## Rule 9 : 
- Do not use "using" in joins
- Having all joins use on is more consistent.
- If additional join conditions need to be added later, on is easier to adapt.
- "Using" can produce inconsistent results with outer joins in some databases

## Rule 10 :
- In join conditions, put the table that was referenced first immediately after "on".
- This makes it easier to determine if the join is going to cause the results to fan out.
    ```
    /* Good */
    select *
    from orders
    left join customers on orders.customer_id = customers.id
    /* foreign key = primary key --> many-to-one --> no fan out */

    /* Bad */
    select *
    from orders
    left join orders on orders.customer_id = customers.id
    ```

With this way, we can make our queries more readable and efficient.