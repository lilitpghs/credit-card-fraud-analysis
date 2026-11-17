-- Q3: When does fraud happen?
-- The six riskiest hours of the day, with a risk index compared with the overall fraud rate
-- (2.0 = twice as risky as average). Uses CTEs and a CROSS JOIN.

WITH hourly AS (
    SELECT Hour,
           COUNT(*)   AS transactions,
           SUM(Class) AS fraud_cases,
           1.0 * SUM(Class) / COUNT(*) AS fraud_rate
    FROM   transactions
    GROUP BY Hour
),
overall AS (SELECT 1.0 * SUM(Class) / COUNT(*) AS avg_rate FROM transactions)
SELECT  h.Hour,
        h.transactions,
        h.fraud_cases,
        ROUND(100 * h.fraud_rate, 3)          AS fraud_rate_pct,
        ROUND(h.fraud_rate / o.avg_rate, 1)   AS risk_index_vs_avg
FROM    hourly h CROSS JOIN overall o
ORDER BY h.fraud_rate DESC
LIMIT 6;
