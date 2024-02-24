drop table sales;

CREATE TABLE sales (
    sale_id SERIAL PRIMARY KEY,
    product_id INT,
    units INT,
    store_cost DECIMAL(10, 2)
);