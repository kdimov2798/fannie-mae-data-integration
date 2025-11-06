SELECT 
  'SOURCE' AS dataset,
  COUNT(*) AS loan_count
FROM `dmi_raw.loan_master_raw`

UNION ALL

SELECT 
  'TARGET',
  COUNT(*)
FROM `dmi_target.msp_loans_production`;


SELECT 
  'SOURCE' AS dataset,
  SUM(original_upb) AS total_orig_upb,
  SUM(current_actual_upb) AS total_curr_upb
FROM `dmi_raw.loan_master_raw`

UNION ALL

SELECT 
  'TARGET',
  SUM(orig_upb),
  SUM(curr_upb)
FROM `dmi_target.msp_loans_production`;


SELECT 
  'SOURCE' AS dataset,
  channel AS code,
  COUNT(*) AS count
FROM `dmi_raw.loan_master_raw`
GROUP BY channel

UNION ALL

SELECT 
  'TARGET',
  orig_channel,
  COUNT(*)
FROM `dmi_target.msp_loans_production`
GROUP BY orig_channel

ORDER BY dataset, code;


WITH random_loans AS (
  SELECT loan_identifier
  FROM `dmi_raw.loan_master_raw`
  ORDER BY RAND()
  LIMIT 10
)
SELECT 
  -- Source fields
  s.loan_identifier AS src_loan_id,
  s.monthly_reporting_period AS src_rpt_period,
  s.channel AS src_channel,
  s.original_interest_rate AS src_orig_rate,
  s.original_upb AS src_orig_upb,
  s.origination_date AS src_orig_date,
  s.loan_purpose_ AS src_loan_purpose,
  
  -- Target fields
  t.loan_id AS tgt_loan_id,
  t.rpt_period AS tgt_rpt_period,
  t.orig_channel AS tgt_channel,
  t.orig_int_rate AS tgt_orig_rate,
  t.orig_upb AS tgt_orig_upb,
  t.orig_date AS tgt_orig_date,
  t.loan_purpose AS tgt_loan_purpose

FROM random_loans r
JOIN `dmi_raw.loan_master_raw` s ON r.loan_identifier = s.loan_identifier
JOIN `dmi_target.msp_loans_production` t ON CAST(s.loan_identifier AS STRING) = t.loan_id;