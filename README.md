# 💳 Credit Card Spend Intelligence
### Consumer Financial Behaviour Analysis Across Indian Cities

![Python](https://img.shields.io/badge/Python-3.12-blue?logo=python&logoColor=white)
![MySQL](https://img.shields.io/badge/MySQL-8.0-orange?logo=mysql&logoColor=white)
![Power BI](https://img.shields.io/badge/Power%20BI-Dashboard-yellow?logo=powerbi&logoColor=white)
![Jupyter](https://img.shields.io/badge/Jupyter-Notebook-orange?logo=jupyter&logoColor=white)
![Status](https://img.shields.io/badge/Status-Complete-brightgreen)

---

## 🔗 Live Dashboard

👉 **[View Interactive Power BI Dashboard](https://app.powerbi.com/groups/me/reports/7a9aff25-ddf4-467e-ac14-65f1c0ab4dff/39b4c16aa293b730b9ed?experience=power-bi)**

> Fully interactive — filter by Year, Card Type, Expense Type, and Gender across both dashboard pages.

---

## 📌 The Business Problem

Banks and financial institutions need to understand *where*, *how*, and *by whom* credit cards are actually being used — not just that transactions are happening. Without this, product teams make broad decisions: blanket offers, untargeted campaigns, and missed risk signals.

This project asks three questions a real business would care about:

1. **Where is money being spent?** — Which cities and categories drive the majority of credit card volume?
2. **Who is spending?** — Does gender or card type predict spending behaviour in a statistically meaningful way?
3. **When does spending shift?** — Are there quarterly or seasonal patterns a bank could act on?

The goal was to answer these questions rigorously — with cleaned data, tested hypotheses, and dashboards a non-technical stakeholder could actually use.

---

## 📊 Project Results at a Glance

| Metric | Value |
|---|---|
| Total Customer Spend | ₹ 4.07 Billion |
| Total Transactions | 26,100 |
| Average Transaction Value | ₹ 156,410 |
| Date Range Covered | Oct 2013 – May 2015 |
| Cities Analysed | 986 |
| Top City by Spend | Mumbai — ₹ 576.8M |
| Top Expense Category | Bills — 22.3% of total spend |
| Highest Spending Segment | Female cardholders — ₹ 2.2bn |
| Quarterly Spend Variation | Not significant (p = 0.53) |
| Gender Spend Difference | Statistically significant (p < 0.05) |

---

## 📊 Dashboards

### Dashboard 1 — Executive Spend Overview
![Executive Spend Overview](screenshots/credit_analysisdb1.png)

Designed for a business stakeholder who needs answers in under 30 seconds. Shows:
- KPI cards: Total Spend, Average Transaction Value, Total Transactions
- Monthly spending trend across the full date range
- Top 10 cities by credit card spend
- Spend breakdown by expense category (donut chart)
- Spend by card type (bar chart)
- Gender split across expense categories (stacked bar)
- Slicers: Year, Card Type, Expense Type, Gender — all cross-filter every visual

---

### Dashboard 2 — Consumer Behaviour & Statistical Insights
![Consumer Behaviour & Statistical Insights](screenshots/credit_analysisdb2.png)

Designed for an analyst who wants to dig deeper. Shows:
- Treemap: Spend distribution across city and expense category simultaneously
- Spend intensity matrix: card type vs expense category (Gold, Platinum, Signature, Silver)
- Decomposition tree: drill into total spend by city, gender, and card type in sequence
- Statistical insight cards: plain-English summaries of all four hypothesis tests with p-values — so the dashboard itself communicates the *confidence* behind the findings, not just the numbers

---

## 🗂️ Project Structure

```
Credit_Card_Spend_Intelligence/
│
├── data/
│   ├── raw/                         
│   └── cleaned/                      
│
├── python/
│   ├── exploration.ipynb            
│   ├── cleaning.ipynb              
│   ├── spend_analysis.ipynb         
│   ├── statistical_testing.ipynb    
│   └── export_to_mysql.ipynb        
│
├── sql/
│   ├── business_questions.sql        # 20+ analytical SQL queries
│   └── views_for_powerbi.sql         # 4 Power BI-ready views
│
├── outputs/
│   ├── csv_exports/                  # Summary tables exported from Python
│   └── statistical_results/          # statistical_test_results.csv
│
├── screenshots/
│   ├── credit_analysisdb1.png
│   └── credit_analysisdb2.png
│
└── README.md
```

---

## 🔧 Tech Stack

| Layer | Tool | Purpose |
|---|---|---|
| Language | Python 3.12 | Data wrangling, analysis, statistical testing |
| Notebooks | Jupyter Notebook | Interactive, cell-by-cell development and debugging |
| Data Manipulation | pandas, numpy | Cleaning, feature engineering, aggregation |
| Statistical Testing | scipy | T-Test, Chi-Square, ANOVA, Pearson Correlation |
| Database | MySQL 8.0 | Persistent storage, business queries, views |
| ORM / Connector | SQLAlchemy, mysql-connector-python | Python-to-MySQL export pipeline |
| BI Dashboards | Microsoft Power BI | Executive and analytical dashboards |
| Data Source | Kaggle | Credit Card Transactions India dataset |

---

## 📁 Dataset

- **Source:** [Kaggle — Credit Card Spending Habits in India](https://www.kaggle.com/datasets/thedevastator/analyzing-credit-card-spending-habits-in-india)
- **Records:** 26,052 transactions
- **Original columns:** Transaction ID, City, Date, Card Type, Expense Type, Gender, Amount
- **Added columns (feature engineering):** Year, Month, Month_Number, Quarter
- **Missing values:** None — dataset was complete at source
- **Note:** Raw CSV is not committed to this repository. Download from Kaggle and place at `data/raw/Credit card transactions - India - Simple.csv`

---

## 🐍 Python Notebooks — Walkthrough

### `exploration.ipynb` — Understanding the Raw Data
First contact with the dataset before touching anything.
- Dataset shape: 26,052 rows × 7 columns
- Data types confirmed — Date was stored as `object`, needed parsing
- Zero null values across all columns
- Value counts revealed 986 unique cities, 4 card types, 6 expense categories, 2 genders
- Statistical summary showed Amount ranging from ₹1,005 to ₹998,077 with mean ₹156,411

---

### `cleaning.ipynb` — Preparing Data for Analysis
Every transformation is deliberate and documented.
- `Date` parsed from string (`29-Oct-14` format) to `datetime64` using `pd.to_datetime()`
- `Amount` cast to numeric with `errors='coerce'` as a safety net
- `Year`, `Month`, `Month_Number`, `Quarter` extracted — `Month_Number` specifically added to enable correct chronological sorting (month names sort alphabetically without it)
- `City` stripped and title-cased to prevent groupby mismatches from inconsistent capitalisation
- Cleaned file written to `data/cleaned/credit_card_cleaned.csv`

---

### `spend_analysis.ipynb` — Aggregation and Summary
Core business summaries produced and exported.
- **By city:** 986 cities ranked — top 4 (Mumbai, Bengaluru, Ahmedabad, Delhi) dominate national spend
- **By expense category:** Bills ₹907M → Food ₹824M → Fuel ₹789M → Entertainment ₹726M → Grocery ₹718M → Travel ₹109M
- **By card type:** Silver ₹1.07bn leads, all four types within 8% of each other
- **By gender:** Female ₹2.2bn vs Male ₹1.87bn — explored further in statistical testing
- **Monthly trend:** 20 months of data showing consistent spend with no dramatic spikes
- **City × Category cross-tab:** Bills is the top category across all four major cities

All six summaries exported as CSVs for MySQL ingestion and Power BI use.

---

### `statistical_testing.ipynb` — Validating What the Numbers Suggest

Patterns in data can be noise. These four tests were chosen to confirm or challenge what the aggregations suggested.

| Test | Hypothesis Tested | Statistic | P-Value | Conclusion |
|---|---|---|---|---|
| **Welch's T-Test** | Male vs female spending differs | t = -8.02 | < 0.0001 | ✅ Significant difference confirmed |
| **Chi-Square** | Expense category depends on city | χ² = 6545.11 | < 0.0001 | ✅ Strong city-category dependency |
| **One-Way ANOVA** | Spending differs across quarters | F = 0.74 | 0.529 | ❌ No quarterly variation |
| **Pearson Correlation** | Spend amount correlates with month | r = -0.01 | 0.088 | ❌ No meaningful time relationship |

Results saved to `outputs/statistical_results/statistical_test_results.csv`, loaded into MySQL, and surfaced directly on Dashboard 2 as plain-English insight cards.

---

### `export_to_mysql.ipynb` — Building the Data Layer
All analytical outputs pushed to MySQL using SQLAlchemy's `to_sql()` with `if_exists='replace'` so the pipeline is fully re-runnable.

| Table | Rows | Description |
|---|---|---|
| `credit_card_master` | 26,052 | Full cleaned dataset |
| `city_summary` | 986 | Total spend per city |
| `category_summary` | 6 | Total spend per expense type |
| `gender_summary` | 2 | Total spend by gender |
| `monthly_summary` | 20 | Monthly spend with year and month number |
| `statistical_results` | 4 | Hypothesis test outcomes |

---

## 🗃️ SQL

### `business_questions.sql` — 20+ Analytical Queries
Covers the full range of SQL techniques:

- **Aggregation:** Total transactions, total spend, average transaction value
- **Filtering and ranking:** Top cities, top categories, highest average transaction cities
- **Window functions:** `LAG()` for month-on-month and quarter-on-quarter growth; `RANK()` for city and gender rankings
- **Partitioning:** Top spending category *within each city* using `RANK() OVER (PARTITION BY City)`
- **Subqueries:** Cities above average spend using `HAVING` with a nested `SELECT AVG()`
- **CASE WHEN:** Transaction size classification (Low / Medium / High)
- **CTEs:** Clean separation of base aggregations from growth calculations

---

### `views_for_powerbi.sql` — Production-Ready Views

Four views built as the data layer for Power BI — keeping transformation logic in SQL rather than Power Query.

| View | Purpose | Used In |
|---|---|---|
| `vw_city_spend` | City-level transactions, total spend, avg value | Dashboard 1 — Top Cities chart |
| `vw_category_spend` | Category breakdown with counts and averages | Dashboard 1 — Donut chart |
| `vw_monthly_trend` | Month-by-month spend and transaction volume | Dashboard 1 — Trend line |
| `vw_consumer_profile` | Segmented by city, gender, and card type | Dashboard 2 — Decomposition tree |

---

## 🧠 Design Decisions

A few choices worth explaining — because *why* matters as much as *what*.

**Why Welch's T-Test instead of Student's T-Test?**
The two gender groups have unequal sample sizes (Female: 13,680 / Male: 12,372) and equal variance between them was not confirmed. Welch's T-Test is the correct choice here — using Student's would have been technically incorrect.

**Why build SQL views instead of connecting Power BI directly to the raw table?**
Direct table connections mean transformation logic lives in Power Query — harder to version control, audit, and reuse. Views keep business logic in SQL where it belongs, make the Power BI model cleaner, and allow any downstream tool to use the same definitions without rebuilding them.

**Why export summary tables to MySQL in addition to the master table?**
Pre-aggregating in Python and storing results means Power BI never has to aggregate 26,000 rows at query time. For this dataset size the speed difference is small — but it is the correct pattern for production-scale data, and building it right from the start is intentional.

**Why add `Month_Number` as a separate column during cleaning?**
Month names sort alphabetically by default (`April` before `January`). Storing `Month_Number` as an integer allows every downstream tool — pandas, MySQL, Power BI — to sort chronologically without additional logic at query time.

---

## 📈 Key Findings

- **The top four cities dominate national credit card volume.** Mumbai (₹576.8M), Bengaluru (₹572.3M), Ahmedabad (₹567.8M), and Delhi (₹556.9M) together dwarf the remaining 982 cities — a bank targeting these four markets reaches the majority of high-value cardholders

- **Indians use credit cards primarily for obligations, not lifestyle.** Bills (22.3%) and Fuel (19.4%) together account for over 40% of all spend — suggesting rewards programmes built around travel or entertainment may be misaligned with how most customers actually use their cards

- **Female cardholders are the higher-value segment — and this is statistically proven.** Female spend (₹2.2bn) exceeds male spend (₹1.87bn) by ₹335M, confirmed not to be sampling noise by Welch's T-Test (p < 0.0001). Any segmentation strategy that treats genders equally is leaving insight on the table

- **Card tier does not predict spend volume.** All four card types sit within 8% of each other in total spend — customers are not spending more simply because they hold a premium card

- **There is no seasonal pattern to exploit or plan around.** The ANOVA result (p = 0.53) tells banks that spend is flat across quarters — no festive spike, no summer dip. Marketing budgets do not need to be front- or back-loaded by season

- **What people spend on is strongly shaped by where they live.** The Chi-Square result (χ² = 6545, p < 0.0001) confirms that expense category choice is city-dependent — a bank offering the same product nationally is ignoring significant local variation in spending behaviour

- **Transaction value cannot be predicted by time of year alone.** The near-zero Pearson correlation (r = -0.01) means month is not a useful feature for any model trying to predict whether a transaction will be high or low value — other variables carry the signal

---

## 🙋 About This Project

I built this project to demonstrate end-to-end data analytics capability — not just Python or just SQL, but the full pipeline a working analyst would actually follow: understanding the data, cleaning it properly, testing assumptions statistically, answering business questions in SQL, and presenting findings in a way a non-technical stakeholder can act on.

Every decision in this project — the test chosen, the column added, the view built instead of a direct table connection — was made deliberately. The Design Decisions section above documents the reasoning.

This project reflects the kind of work I want to do professionally: structured, rigorous, and always connected back to a question worth answering.

**Connect with me on [LinkedIn](https://www.linkedin.com/in/bibha-kumari-7539ab247/)**

---

*Dataset: [Kaggle — Analyzing Credit Card Spending Habits in India](https://www.kaggle.com/datasets/thedevastator/analyzing-credit-card-spending-habits-in-india)*
