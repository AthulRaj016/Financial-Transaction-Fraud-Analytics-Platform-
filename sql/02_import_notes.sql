/*
Load the full PaySim CSV into the staging table with BCP.
Run this command from Command Prompt / terminal, not inside SQL Server.

bcp dbo.stg_transactions in "D:\financial-transactions-bi-dashboard\data\raw\paysim dataset.csv" -S localhost -d financial_transactions_db -T -c -t, -r 0x0a -F 2

Expected full-dataset row count: 6,362,620
*/
