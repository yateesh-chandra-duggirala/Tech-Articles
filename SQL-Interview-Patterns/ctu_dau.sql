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
