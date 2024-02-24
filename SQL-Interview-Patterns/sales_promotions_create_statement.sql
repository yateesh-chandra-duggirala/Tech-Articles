CREATE TABLE sales (
    sale_id INT PRIMARY KEY,
    transaction_date DATE,
    promotion_id INT
);

CREATE TABLE promotions (
    promotion_id INT PRIMARY KEY,
    start_date DATE,
    end_date DATE
);