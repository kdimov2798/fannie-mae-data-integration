CREATE OR REPLACE TABLE `dmi_staging.loan_master_trial` AS
SELECT *
FROM `dmi_raw.loan_master_raw`
WHERE RAND() < (1000.0 / 388622.0)  -- Approximately 1,000 random loans
LIMIT 1000;


SELECT 
COUNT(*) AS trial_sample_count
FROM `dmi_staging.loan_master_trial`;


#Loan distribution checks
SELECT 
  'FULL' AS dataset,
  loan_purpose_,
  COUNT(*) AS count,
  ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER(), 2) AS pct
FROM `dmi_raw.loan_master_raw`
GROUP BY loan_purpose_

UNION ALL

SELECT 
  'TRIAL',
  loan_purpose_,
  COUNT(*),
  ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER(), 2)
FROM `dmi_trial.loan_master_trial`
GROUP BY loan_purpose_

ORDER BY dataset, loan_purpose_;


SELECT 
  'FULL' AS dataset,
  property_type,
  COUNT(*) AS count,
  ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER(), 2) AS pct
FROM `dmi_raw.loan_master_raw`
GROUP BY property_type

UNION ALL

SELECT 
  'TRIAL',
  property_type,
  COUNT(*),
  ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER(), 2)
FROM `dmi_staging.loan_master_trial`
GROUP BY property_type

ORDER BY dataset, property_type;


SELECT 
  'FULL' AS dataset,
  property_state,
  COUNT(*) AS state_count
FROM `dmi_raw.loan_master_raw`
GROUP BY property_state

UNION ALL

SELECT 
  'TRIAL',
  property_state,
  COUNT(*) AS state_count
FROM `dmi_staging.loan_master_trial`
GROUP BY property_state

ORDER BY dataset, count DESC;
