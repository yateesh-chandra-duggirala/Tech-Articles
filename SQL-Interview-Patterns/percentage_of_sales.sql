SELECT ROUND(Sum(
  CASE WHEN Min(start_date) = transaction_date THEN 1
       WHEN Max(end_date) = transaction_date THEN 1
       ELSE 0
  END) 100 / Count(), 2)
FROM sales s
JOIN promotions p
ON s.promotion_id = p.promotion_id;