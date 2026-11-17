-- Q1: How big is the fraud problem each day?
-- Transactions, fraud cases, fraud rate and money lost per day.
-- Table: transactions (see README.md in this folder)

SELECT  Day,
        COUNT(*)                                        AS transactions,
        SUM(Class)                                      AS fraud_cases,
        ROUND(100.0 * SUM(Class) / COUNT(*), 3)         AS fraud_rate_pct,
        ROUND(SUM(Amount), 0)                           AS total_value,
        ROUND(SUM(CASE WHEN Class = 1 THEN Amount END), 0) AS fraud_value
FROM    transactions
GROUP BY Day
ORDER BY Day;
