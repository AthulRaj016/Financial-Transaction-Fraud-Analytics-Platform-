USE financial_transactions_db;
GO

-- 1. Overall dataset summary
SELECT 
    COUNT(*) AS total_rows,
    COUNT(DISTINCT nameOrig) AS unique_origin_accounts,
    COUNT(DISTINCT nameDest) AS unique_destination_accounts,
    SUM(amount) AS total_transaction_value,
    AVG(amount) AS average_transaction_amount,
    MIN(amount) AS min_transaction_amount,
    MAX(amount) AS max_transaction_amount
FROM dbo.raw_transactions;

-- 2. Transaction type distribution
SELECT 
    type,
    COUNT(*) AS transaction_count,
    SUM(amount) AS total_amount,
    AVG(amount) AS avg_amount
FROM dbo.raw_transactions
GROUP BY type
ORDER BY transaction_count DESC;

-- 3. Fraud vs non-fraud summary
SELECT 
    isFraud,
    COUNT(*) AS transaction_count,
    SUM(amount) AS total_amount,
    AVG(amount) AS avg_amount
FROM dbo.raw_transactions
GROUP BY isFraud;

-- 4. Fraud rate by transaction type
SELECT 
    type,
    COUNT(*) AS total_transactions,
    SUM(CASE WHEN isFraud = 1 THEN 1 ELSE 0 END) AS fraud_transactions,
    CAST(SUM(CASE WHEN isFraud = 1 THEN 1 ELSE 0 END) AS FLOAT) / COUNT(*) AS fraud_rate
FROM dbo.raw_transactions
GROUP BY type
ORDER BY fraud_rate DESC;

-- 5. Flagged fraud vs actual fraud
SELECT 
    isFraud,
    isFlaggedFraud,
    COUNT(*) AS transaction_count,
    SUM(amount) AS total_amount
FROM dbo.raw_transactions
GROUP BY isFraud, isFlaggedFraud
ORDER BY isFraud DESC, isFlaggedFraud DESC;
