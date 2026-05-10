analysis_queries.sql

-- Q1
SELECT 
    status_standardized,
    COUNT(*) AS transaction_count
FROM cleaned_transactions
GROUP BY status_standardized;

-- Q2
SELECT 
    merchant_name_clean,
    SUM(amount_usd) AS captured_gmv
FROM cleaned_transactions
WHERE status_standardized = 'captured'
GROUP BY merchant_name_clean; 

-- Q3
SELECT 
    merchant_name_clean,
    SUM(amount_usd) AS captured_gmv
FROM cleaned_transactions
WHERE status_standardized = 'captured'
GROUP BY merchant_name_clean
ORDER BY captured_gmv DESC
LIMIT 10; 

-- Q4
SELECT 
    transaction_date,
    SUM(amount_usd) AS daily_gmv,
    COUNT(*) AS successful_transaction_count
FROM cleaned_transactions
WHERE status_standardized = 'captured'
GROUP BY transaction_date
ORDER BY transaction_date; 

-- Q5
SELECT 
    merchant_name_clean,
    SUM(CASE WHEN status_standardized = 'chargeback' THEN 1 ELSE 0 END) * 100.0 / COUNT(*) AS chargeback_ratio
FROM cleaned_transactions
GROUP BY merchant_name_clean
HAVING chargeback_ratio > 1; 

-- Q6
SELECT 
    gateway_region_clean,
    AVG(risk_score_clean) AS avg_risk_score,
    COUNT(*) AS transaction_count
FROM cleaned_transactions
GROUP BY gateway_region_clean
HAVING AVG(risk_score_clean) > 50
AND COUNT(*) > 20; 

-- Q7
SELECT 
    user_id,
    transaction_date,
    COUNT(*) AS failed_or_chargeback_count
FROM cleaned_transactions
WHERE status_standardized IN ('failed', 'chargeback')
GROUP BY user_id, transaction_date
HAVING COUNT(*) >= 3;

-- Q8
SELECT 
    merchant_name_clean,
    COUNT(*) AS chargeback_count,
    COUNT(DISTINCT user_id) AS unique_affected_users,
    SUM(amount_usd) AS chargeback_amount
FROM cleaned_transactions
WHERE status_standardized = 'chargeback'
GROUP BY merchant_name_clean;