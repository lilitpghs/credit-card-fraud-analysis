# Credit Card Fraud Analysis

Where does card fraud happen, how much does it cost, and which transactions should a fraud team review first? This project answers those questions using 283,726 real, anonymized card transactions.

**Tools:** Python (pandas, NumPy), SQL (SQLite), Matplotlib, Seaborn, scikit-learn

**[View the full analysis notebook](credit_card_fraud_analysis.ipynb)**

## Key findings

- **Scale:** 473 transactions were fraud (0.167%), worth €58.6k over 2 days.
- **Timing:** hours 00–06 hold 10% of transactions but 26% of fraud. The fraud rate is 3.3× the rate at other hours.
- **Amounts:** 36% of frauds are €1 or less, which is consistent with card testing. Transactions over €250 are 8% of volume but 74% of fraud losses.
- **Review targeting:** with the same 219 reviews on the test set, checking the largest transactions caught 0% of fraud. A simple 3-signal rule caught 78%, and a logistic regression risk score caught 81%.
- **Review budget:** of the budgets tested, reviewing the riskiest 0.2% of transactions gave the highest net savings. It prevented 80% of fraud value in the test set, about €15k after an assumed €5 cost per review.

![Fraud rate by hour of day](figures/03_hourly_fraud_rate.png)

![Comparison of review strategies](figures/07_strategy_comparison.png)

![Net savings by review budget](figures/09_review_budget_roi.png)

## Business questions

1. How big is the fraud problem in volume, rate and money lost?
2. Do fraudulent transactions differ in amount?
3. When does fraud happen?
4. Which amount bands carry the highest risk and the biggest losses?
5. Which signals best separate fraud from legitimate transactions?
6. If analysts can only review a limited number of transactions, which should they review, and what is the financial return?

## Recommendations

1. Replace amount-based review with signal-based risk scoring.
2. Set the review budget from the savings curve, starting near the riskiest 0.2% of transactions. At this dataset's volume, that is about 280 alerts per day.
3. Test tighter controls overnight, and measure the effect before rolling them out.
4. Treat transactions of €1 or less as a possible card-testing warning, and monitor the card for follow-up attempts.
5. Put high-value alerts first in the analyst queue.

## Data

The data is the [Credit Card Fraud Detection dataset](https://www.kaggle.com/datasets/mlg-ulb/creditcardfraud) from Kaggle (Machine Learning Group, ULB). It covers 2 days of transactions by European cardholders in September 2013.

- **Rows:** 284,807 raw rows, or 283,726 after removing 1,081 exact duplicates.
- **Columns:** `Time`, `Amount`, `Class` (1 = fraud) and `V1`–`V28`, which are anonymized PCA features.

The CSV is about 144 MB, which is over GitHub's 100 MB file limit, so it is not in this repository.

## Method

1. **Data quality:** checked for missing values, duplicates, negative amounts and zero-value transactions.
2. **Feature engineering:** derived the hour, day and amount band of each transaction.
3. **Exploratory analysis:** calculated KPIs and compared fraud by hour, amount band and signal.
4. **SQL:** answered the core questions again in SQL, using CTEs and window functions.
5. **Strategy comparison:** compared three ways of choosing transactions to review, on a 30% held-out test set. Rule signals, rule cut-offs and the risk model were learned from the training set only.
6. **Business impact:** estimated net savings across seven review budgets.

## Limitations

- **Anonymized features:** `V1`–`V28` can be ranked but not explained in business terms.
- **Short window:** two days of data cannot show weekly or seasonal patterns.
- **Clock time is inferred:** `Time` counts seconds from the first transaction, and the dataset does not give the clock time of that transaction. The "night" findings assume the recording starts near midnight, based on the overnight dip in volume.
- **Simplified cost model:** savings assume a €5 review cost and that every reviewed fraud is fully prevented. The €5 is an illustrative assumption, not a real figure.
- **Budget chosen on test data:** the best review budget was picked on the same test set it is reported on, so the savings need validating on new data.
- **Currency:** the dataset does not state one. Amounts are shown in € because the cardholders were European.

## Repository structure

```text
├── credit_card_fraud_analysis.ipynb   # Full analysis, with outputs
├── figures/                           # Charts used in the analysis
├── outputs/                           # Summary tables for Tableau, Power BI or Excel
├── requirements.txt
└── README.md
```

## Run it yourself

1. Clone the repository, replacing `<your-username>` and `<repo-name>` with your own:

   ```bash
   git clone https://github.com/<your-username>/<repo-name>.git
   ```

2. Install the dependencies from inside the project folder:

   ```bash
   pip install -r requirements.txt
   ```

3. Download `creditcard.csv` from [Kaggle](https://www.kaggle.com/datasets/mlg-ulb/creditcardfraud) and put it next to the notebook.

4. Open the notebook and run all cells:

   ```bash
   jupyter notebook credit_card_fraud_analysis.ipynb
   ```

## Author

**Lilit Poghosyan**
