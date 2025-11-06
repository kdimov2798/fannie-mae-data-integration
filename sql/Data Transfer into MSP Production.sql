INSERT INTO dmi_target.msp_loans_production (
    loan_id, rpt_period, orig_channel, seller_name, servicer_name,
    orig_int_rate, curr_int_rate, orig_upb, curr_upb, orig_term,
    orig_date, first_pmt_date, loan_age, rem_mths_legal_mat, rem_mths_mat,
    maturity_date, orig_ltv, orig_cltv, borrower_ct, dti,
    credit_score, fthb_flag, loan_purpose, prop_type, units_ct,
    occupancy, prop_state, msa_code, zip_code, amort_type,
    prepay_penalty_flag, io_flag, delq_status, pmt_history, mod_flag,
    zb_code, zb_eff_date, zb_epb, prin_curr, srv_activity_flag,
    special_prog, relo_flag, val_method, high_bal_flag, assist_plan,
    hltv_flag, rebuy_flag, alt_delq_res
)
SELECT
    CAST(loan_identifier AS STRING) AS loan_id,
    PARSE_DATE('%m%Y', LPAD(CAST(monthly_reporting_period AS STRING), 6, '0')) AS rpt_period,
    CASE CAST(channel AS STRING)
        WHEN 'R' THEN 'Retail'
        WHEN 'C' THEN 'Correspondent'
        WHEN 'B' THEN 'Broker'
        ELSE NULL
    END AS orig_channel,
    seller_name, servicer_name,
    original_interest_rate AS orig_int_rate,
    current_interest_rate AS curr_int_rate,
    original_upb AS orig_upb,
    current_actual_upb AS curr_upb,
    original_loan_term AS orig_term,
    PARSE_DATE('%m%Y', LPAD(CAST(origination_date AS STRING), 6, '0')) AS orig_date,
    PARSE_DATE('%m%Y', LPAD(CAST(first_payment_date AS STRING), 6, '0')) AS first_pmt_date,
    loan_age,
    remaining_months_to_legal_maturity AS rem_mths_legal_mat,
    remaining_months_to_maturity AS rem_mths_mat,
    PARSE_DATE('%m%Y', LPAD(CAST(maturity_date AS STRING), 6, '0')) AS maturity_date,
    original_loan_to_value_ratio__ltv_ AS orig_ltv,
    original_combined_loan_to_value_ratio__cltv_ AS orig_cltv,
    number_of_borrowers AS borrower_ct,
    `debt-to-income__dti_` AS dti,
    borrower_credit_score_at_origination AS credit_score,
    first_time_home_buyer_indicator AS fthb_flag,
    CASE CAST(loan_purpose_ AS STRING)
        WHEN 'C' THEN 'Cash-Out Refinance'
        WHEN 'R' THEN 'Refinance'
        WHEN 'P' THEN 'Purchase'
        WHEN 'U' THEN 'Refinance-Not Specified'
        ELSE NULL
    END AS loan_purpose,
    CASE CAST(property_type AS STRING)
        WHEN 'CO' THEN 'Condominium'
        WHEN 'CP' THEN 'Co-Operative'
        WHEN 'PU' THEN 'Planned Urban Development'
        WHEN 'MH' THEN 'Manufactured Home'
        WHEN 'SF' THEN 'Single-Family Home'
        ELSE NULL
    END AS prop_type,
    number_of_units AS units_ct,
    CASE CAST(occupancy_status AS STRING)
        WHEN 'P' THEN 'Principal'
        WHEN 'S' THEN 'Second'
        WHEN 'I' THEN 'Investor'
        WHEN 'U' THEN 'Unknown'
        ELSE NULL
    END AS occupancy,
    property_state AS prop_state,
    metropolitan_statistical_area__msa_ AS msa_code,
    zip_code_short AS zip_code,
    amortization_type AS amort_type,
    prepayment_penalty_indicator AS prepay_penalty_flag,
    interest_only_loan_indicator AS io_flag,
    current_loan_delinquency_status AS delq_status,
    loan_payment_history AS pmt_history,
    modification_flag AS mod_flag,
    zero_balance_code AS zb_code,
    PARSE_DATE('%m%Y', LPAD(CAST(zero_balance_effective_date AS STRING), 6, '0')) AS zb_eff_date,
    upb_at_the_time_of_removal AS zb_epb,
    total_principal_current AS prin_curr,
    servicing_activity_indicator AS srv_activity_flag,
    special_eligibility_program AS special_prog,
    relocation_mortgage_indicator AS relo_flag,
    property_valuation_method_ AS val_method,
    high_balance_loan_indicator_ AS high_bal_flag,
    borrower_assistance_plan AS assist_plan,
    high_loan_to_value__hltv__refinance_option_indicator AS hltv_flag,
    repurchase_make_whole_proceeds_flag AS rebuy_flag,
    alternative_delinquency_resolution AS alt_delq_res
FROM dmi_raw.loan_master_raw;