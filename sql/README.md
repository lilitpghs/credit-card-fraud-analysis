# SQL queries

The SQL used in the analysis, as standalone files. The same queries run inside the notebook ([`credit_card_fraud_analysis.ipynb`](../credit_card_fraud_analysis.ipynb), sections 9 and 10), where you can see their results.

| File | Business question | SQL techniques |
|---|---|---|
| [`01_kpi_by_day.sql`](01_kpi_by_day.sql) | How big is the fraud problem each day? | aggregation, `CASE WHEN` |
| [`02_riskiest_hours.sql`](02_riskiest_hours.sql) | When does fraud happen? | CTEs, `CROSS JOIN` |
| [`03_losses_by_amount_band.sql`](03_losses_by_amount_band.sql) | Where is the money lost? | CTE, window functions (`SUM() OVER`) |
| [`04_alert_rules.sql`](04_alert_rules.sql) | Which alert rule should a fraud team start with? | CTE, `UNION ALL`, subqueries |

## The `transactions` table

The cleaned dataset (283,726 rows, duplicates removed) loaded into SQLite, one row per transaction.

| Column | Meaning |
|---|---|
| `Time` | seconds since the first transaction |
| `V1`–`V28` | anonymized features |
| `Amount` | transaction amount (€) |
| `Class` | 1 = fraud, 0 = legitimate |
| `Hour` | hour of day (0–23), derived from `Time` |
| `Day` | day 1 or 2, derived from `Time` |
| `Amount_Band` | amount group, e.g. `€0-1`, `€250-500` |
| `Label` | `Fraud` or `Legitimate` |
