CREATE DATABASE IF NOT EXISTS customer_churn;

USE customer_churn;
CREATE TABLE churn_predictions (
    customerID VARCHAR(20),
    Churn_Probability DECIMAL(6,4),
    Predicted_Churn INT,
    Risk_Category VARCHAR(20),
    tenure INT,
    MonthlyCharges DECIMAL(10,2),
    TotalCharges DECIMAL(10,2),
    Contract VARCHAR(30),
    InternetService VARCHAR(30),
    PaymentMethod VARCHAR(50),
    Churn VARCHAR(5)
);
USE customer_churn;

SHOW TABLES;

USE customer_churn;

SELECT COUNT(*) AS total_rows
FROM churn_predictions;

SELECT *
FROM churn_predictions
LIMIT 5;

SELECT
    COUNT(*) AS total_customers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
    ROUND(
        SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*),
        2
    ) AS churn_rate
FROM churn_predictions;

SELECT
    Contract,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
    ROUND(
        SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*),
        2
    ) AS churn_rate
FROM churn_predictions
GROUP BY Contract
ORDER BY churn_rate DESC;

SELECT
    PaymentMethod,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
    ROUND(
        SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*),
        2
    ) AS churn_rate
FROM churn_predictions
GROUP BY PaymentMethod
ORDER BY churn_rate DESC;

SELECT
    InternetService,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
    ROUND(
        SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*),
        2
    ) AS churn_rate
FROM churn_predictions
GROUP BY InternetService
ORDER BY churn_rate DESC;

SELECT
    Contract,
    Risk_Category,
    COUNT(*) AS total_customers,
    ROUND(AVG(Churn_Probability) * 100, 2) AS avg_churn_probability
FROM churn_predictions
GROUP BY Contract, Risk_Category
ORDER BY avg_churn_probability DESC;