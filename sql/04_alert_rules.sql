-- Q6: Which simple alert rule should a fraud team start with?
-- Compares six alert rules on how many checks they create, how many checks it takes
-- to find one fraud, and how much fraud money each check covers.
-- The data covers 2 days, so checks_per_day = checks / 2.

WITH rule_checks AS (
    SELECT 'Check everything' AS rule, Class, Amount FROM transactions
    UNION ALL
    SELECT 'Night hours', Class, Amount FROM transactions WHERE Hour BETWEEN 0 AND 6
    UNION ALL
    SELECT '€1 or less', Class, Amount FROM transactions WHERE Amount <= 1
    UNION ALL
    SELECT 'Over €250', Class, Amount FROM transactions WHERE Amount > 250
    UNION ALL
    SELECT 'Night + €1 or less', Class, Amount FROM transactions WHERE Hour BETWEEN 0 AND 6 AND Amount <= 1
    UNION ALL
    SELECT 'Night + over €250', Class, Amount FROM transactions WHERE Hour BETWEEN 0 AND 6 AND Amount > 250
)
SELECT  rule,
        COUNT(*)                                     AS checks,
        COUNT(*) / 2                                 AS checks_per_day,
        SUM(Class)                                   AS frauds_found,
        ROUND(100.0 * SUM(Class) / (SELECT SUM(Class) FROM transactions), 1) AS pct_of_frauds,
        ROUND(1.0 * COUNT(*) / SUM(Class), 0)        AS checks_per_fraud,
        ROUND(SUM(Class * Amount), 0)                AS fraud_money,
        ROUND(100.0 * SUM(Class * Amount) / (SELECT SUM(Class * Amount) FROM transactions), 1) AS pct_of_fraud_money,
        ROUND(SUM(Class * Amount) / COUNT(*), 2)     AS fraud_money_per_check
FROM    rule_checks
GROUP BY rule
ORDER BY checks_per_fraud DESC;
