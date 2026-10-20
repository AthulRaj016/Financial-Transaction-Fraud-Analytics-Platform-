# Financial Transaction & Fraud Analytics Platform

An end-to-end SQL analytics project built on the PaySim financial transaction dataset. The solution processes **6,362,620 transactions** through staging, raw, data-quality, profiling, and reporting-ready layers to investigate transaction behaviour and fraud-monitoring effectiveness.

## Key Findings

- **6,362,620** transactions were loaded and reconciled between staging and raw layers.
- **8,213** transactions were labelled as fraudulent.
- Only **16** transactions were system-flagged, and all 16 were actual fraud cases.
- **8,197** fraudulent transactions were not system-flagged, exposing a major monitoring gap.
- No nulls were found in the critical fields checked during validation.
- **16** zero-amount transactions were identified and no negative transaction amounts were found.

## Architecture

```text
PaySim CSV
    |
    v
SQL Server BCP ingestion
    |
    v
dbo.stg_transactions
    |
    v
Validation / reconciliation
    |
    v
dbo.raw_transactions
    |
    v
Data profiling + data quality checks
    |
    v
dbo.vw_transaction_analytics
    |
    v
BI reporting layer
```

The current repository focuses on the completed SQL analytics pipeline. A Power BI dashboard is planned as the next presentation layer.

## Repository Structure

```text
sql/
  01_create_tables.sql
  02_import_notes.sql
  03_data_profiling.sql
  04_load_raw.sql
  05_data_quality.sql
  06_reporting_views.sql

Sampling.py
data/README.md
```

## Data Pipeline

### 1. Staging layer
The full PaySim CSV is loaded into `dbo.stg_transactions` using SQL Server BCP.

### 2. Raw layer
Validated staging records are loaded into `dbo.raw_transactions`, which adds an identity-based transaction key and load timestamp.

### 3. Profiling and validation
SQL checks cover:
- transaction counts and value statistics
- transaction-type distribution
- fraud vs non-fraud activity
- fraud rate by transaction type
- flagged fraud vs actual fraud
- staging-to-raw reconciliation
- null checks
- zero and negative amount checks

### 4. Reporting layer
`dbo.vw_transaction_analytics` adds reporting-friendly fields such as:
- simulation day
- simulation hour
- transaction type
- origin balance change
- destination balance change
- fraud and flag indicators

## Technologies

- SQL Server
- T-SQL
- BCP
- Python / pandas
- VS Code
- Power BI (reporting layer in progress)

## Reproducing the Project

1. Download the PaySim dataset and place the source CSV under `data/raw/`.
2. Create a SQL Server database named `financial_transactions_db`.
3. Run `sql/01_create_tables.sql`.
4. Update the local file path in `sql/02_import_notes.sql` and run the documented BCP command.
5. Run `sql/04_load_raw.sql`.
6. Run `sql/05_data_quality.sql` and verify reconciliation results.
7. Run `sql/03_data_profiling.sql` for exploratory analysis.
8. Run `sql/06_reporting_views.sql` to create the BI-ready analytical view.

## Dataset

This project uses the PaySim synthetic mobile-money transaction dataset. The full source dataset is intentionally not committed to this repository because of its size. The `data/raw/` directory is excluded through `.gitignore`.

## Future Enhancements

- Complete an interactive Power BI executive dashboard.
- Add fraud-risk and transaction-behaviour pages.
- Add additional reporting views and KPI measures.
- Reintroduce a cloud deployment layer when an Azure environment is available.
