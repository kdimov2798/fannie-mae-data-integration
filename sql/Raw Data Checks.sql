#Row data overview
SELECT
COUNT(*) AS total_loans
FROM `dmi_raw.loan_master_raw`;


#Null/completeness checks
SELECT
  COUNT(*) AS total_loans,
  COUNTIF(loan_identifier IS NULL) AS null_loan_id,
  COUNTIF(original_upb IS NULL) AS null_orig_upb,
  COUNTIF(current_actual_upb IS NULL) AS null_curr_upb,
  COUNTIF(original_interest_rate IS NULL) AS null_interest_rate,
  COUNTIF(origination_date IS NULL) AS null_orig_date,
  COUNTIF(borrower_credit_score_at_origination IS NULL) AS null_credit_score
FROM `dmi_raw.loan_master_raw`;


#Duplicate checks
SELECT
  COUNT(*) AS total_rows,
  COUNT(DISTINCT loan_identifier) AS unique_loans,
  COUNT(*) - COUNT(DISTINCT loan_identifier) AS duplicate_count
FROM `dmi_raw.loan_master_raw`;

SELECT
  COUNT(*) AS total_rows,
  COUNT(DISTINCT CONCAT(CAST(loan_identifier AS STRING), '_', CAST(monthly_reporting_period AS STRING))) AS distinct_loan_reporting_pairs,
  COUNT(*) - COUNT(DISTINCT CONCAT(CAST(loan_identifier AS STRING), '_', CAST(monthly_reporting_period AS STRING))) AS duplicate_pairs
FROM `dmi_raw.loan_master_raw`;


#Numeric checks
SELECT
  COUNTIF(original_interest_rate < 0 OR original_interest_rate > 20) AS invalid_interest_rate,
  COUNTIF(original_upb < 0) AS negative_upb,
  COUNTIF(current_actual_upb < 0) AS negative_current_upb,
  COUNTIF(borrower_credit_score_at_origination < 300 OR borrower_credit_score_at_origination > 850) AS invalid_credit_score
FROM `dmi_raw.loan_master_raw`;


#Distribution analysis
SELECT 
  loan_purpose_,
  COUNT(*) AS loan_count,
  ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER(), 2) AS percentage
FROM `dmi_raw.loan_master_raw`
GROUP BY loan_purpose_
ORDER BY loan_count DESC;


SELECT 
  property_type,
  COUNT(*) AS loan_count,
  ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER(), 2) AS percentage
FROM `dmi_raw.loan_master_raw`
GROUP BY property_type
ORDER BY loan_count DESC;


SELECT 
  property_state,
  COUNT(*) AS loan_count,
  ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER(), 2) AS percentage
FROM `dmi_raw.loan_master_raw`
GROUP BY property_state
ORDER BY loan_count DESC







