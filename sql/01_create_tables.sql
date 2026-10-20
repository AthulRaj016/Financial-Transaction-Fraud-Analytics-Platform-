USE financial_transactions_db;
GO

CREATE TABLE dbo.raw_transactions (
    transaction_id BIGINT IDENTITY(1,1) PRIMARY KEY,
    step INT,
    type VARCHAR(50),
    amount DECIMAL(18,2),
    nameOrig VARCHAR(100),
    oldbalanceOrg DECIMAL(18,2),
    newbalanceOrig DECIMAL(18,2),
    nameDest VARCHAR(100),
    oldbalanceDest DECIMAL(18,2),
    newbalanceDest DECIMAL(18,2),
    isFraud BIT,
    isFlaggedFraud BIT,
    load_date DATETIME2 DEFAULT GETDATE()
);
GO

CREATE TABLE dbo.stg_transactions (
    step INT,
    type VARCHAR(50),
    amount DECIMAL(18,2),
    nameOrig VARCHAR(100),
    oldbalanceOrg DECIMAL(18,2),
    newbalanceOrig DECIMAL(18,2),
    nameDest VARCHAR(100),
    oldbalanceDest DECIMAL(18,2),
    newbalanceDest DECIMAL(18,2),
    isFraud BIT,
    isFlaggedFraud BIT
);
GO
