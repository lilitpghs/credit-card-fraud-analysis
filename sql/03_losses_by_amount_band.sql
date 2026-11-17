-- Q4: Where is the money lost?
-- Fraud losses by amount band, each band's share of total losses and the running share
-- from the largest band down. Uses a CTE and window functions.

WITH band AS (
    SELECT Amount_Band,
           MIN(Amount)                             AS band_min,
           SUM(Class)                              AS fraud_cases,
           SUM(CASE WHEN Class = 1 THEN Amount ELSE 0 END) AS fraud_value
    FROM   transactions
    GROUP BY Amount_Band
)
SELECT  Amount_Band,
        fraud_cases,
        ROUND(fraud_value, 0) AS fraud_value,
        ROUND(100.0 * fraud_value / SUM(fraud_value) OVER (), 1) AS pct_of_loss,
        ROUND(100.0 * SUM(fraud_value) OVER (ORDER BY band_min DESC) / SUM(fraud_value) OVER (), 1)
            AS cumulative_pct_from_top
FROM    band
ORDER BY band_min DESC;
