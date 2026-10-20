USE financial_transactions_db;
GO

-- 1. Staging vs raw row reconciliation
SELECT
    (SELECT COUNT(*) FROM dbo.stg_transactions) AS staging_rows,
    (SELECT COUNT(*) FROM dbo.raw_transactions) AS raw_rows;

-- 2. Null checks on critical fields
SELECT
    SUM(CASE WHEN step IS NULL THEN 1 ELSE 0 END) AS null_step,
    SUM(CASE WHEN type IS NULL THEN 1 ELSE 0 END) AS null_type,
    SUM(CASE WHEN amount IS NULL THEN 1 ELSE 0 END) AS null_amount,
    SUM(CASE WHEN nameOrig IS NULL THEN 1 ELSE 0 END) AS null_nameOrig,
    SUM(CASE WHEN nameDest IS NULL THEN 1 ELSE 0 END) AS null_nameDest,
    SUM(CASE WHEN isFraud IS NULL THEN 1 ELSE 0 END) AS null_isFraud,
    SUM(CASE WHEN isFlaggedFraud IS NULL THEN 1 ELSE 0 END) AS null_isFlaggedFraud
FROM dbo.raw_transactions;

-- 3. Zero / negative amount checks
SELECT
    SUM(CASE WHEN amount = 0 THEN 1 ELSE 0 END) AS zero_amount_transactions,
    SUM(CASE WHEN amount < 0 THEN 1 ELSE 0 END) AS negative_amount_transactions
FROM dbo.raw_transactions;

-- 4. Fraud / flagged consistency
SELECT
    isFraud,
    isFlaggedFraud,
    COUNT(*) AS transaction_count
FROM dbo.raw_transactions
GROUP BY isFraud, isFlaggedFraud
ORDER BY isFraud DESC, isFlaggedFraud DESC;
