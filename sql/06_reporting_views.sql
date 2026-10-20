USE financial_transactions_db;
GO

CREATE OR ALTER VIEW dbo.vw_transaction_analytics AS
SELECT
    transaction_id,
    step,
    ((step - 1) / 24) + 1 AS simulation_day,
    ((step - 1) % 24) AS simulation_hour,
    type AS transaction_type,
    amount,
    nameOrig,
    oldbalanceOrg,
    newbalanceOrig,
    oldbalanceOrg - newbalanceOrig AS origin_balance_change,
    nameDest,
    oldbalanceDest,
    newbalanceDest,
    newbalanceDest - oldbalanceDest AS destination_balance_change,
    isFraud,
    isFlaggedFraud,
    load_date
FROM dbo.raw_transactions;
GO

SELECT COUNT(*) AS reporting_rows
FROM dbo.vw_transaction_analytics;
