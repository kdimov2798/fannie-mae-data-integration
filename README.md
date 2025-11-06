# Fannie Mae Mortgage Portfolio Data Integration Project

## Project Overview

This project simulates the complete data integration workflow of a **Data Integration Analyst** at a mortgage subservicing firm. Using Fannie Mae's 2025 Q1 Single-Family Loan Performance dataset, I replicated the end-to-end **Transfer of Servicing (TOS)** process—migrating 388,622 mortgage loans from a source system into a simulated MSP (Mortgage Servicing Platform) environment.

**Key Objective:** Demonstrate proficiency in data profiling, transformation, reconciliation, and documentation for mortgage servicing conversions.

---

## Dataset Information

- **Source:** Fannie Mae Single-Family Loan Performance Data (2025 Q1)
- **Total Records:** 388,622 mortgage loans
- **Source Fields:** 110 columns
- **Migrated Fields:** 48 critical servicing fields
- **Data Types:** Loan demographics, balances, rates, payment history, property information, investor data

---

## Technologies & Tools

- **Database & Query:** Google BigQuery (SQL)
- **Data Transformation:** SQL (CASE statements, PARSE_DATE, type conversions, code mappings)
- **Documentation:** Microsoft Excel
- **Version Control:** Git / GitHub

---

## Project Structure

```
fannie-mae-data-integration/
├── README.md                              # Project documentation (this file)
├── sql/                                   # SQL scripts organized by workflow phase
│   ├── 01_data_profiling.sql             # Initial data quality checks on 388K loans
│   ├── 02_trial_sample_creation.sql      # Create 1,000-loan test sample
│   ├── 03_trial_transformation.sql       # Transform trial data to MSP format
│   ├── 04_trial_reconciliation.sql       # Validate trial load accuracy
│   ├── 05_production_transformation.sql  # Transform full 388K dataset
│   ├── 06_production_reconciliation.sql  # Final production validation
│   ├── 07_additional_validations.sql     # Field-level and date logic checks
│   └── 08_distribution_analysis.sql      # Portfolio composition analysis
├── documentation/
│   └── Fannie_Mae_Conversion_Documentation.xlsx  # Comprehensive project documentation
└── data_dictionary/
    └── [Fannie Mae data dictionary reference]
```

---

## Workflow & Methodology

### **Phase 1: Data Profiling (Full Dataset - 388,622 loans)**

**Objective:** Assess data quality and understand portfolio composition before migration.

**Key Activities:**
- Row count validation
- Duplicate detection (composite key: `loan_identifier + monthly_reporting_period`)
- Null value analysis across 48 critical fields
- Outlier detection (interest rates, balances, credit scores)
- Portfolio distribution analysis (loan purpose, property type, geographic concentration)

**Results:**
- ✅ Zero duplicate loans
- ✅ <0.2% null values in critical fields (722 credit score nulls - acceptable for vintage loans)
- ✅ No invalid values detected

---

### **Phase 2: Trial Balance (1,000-loan sample)**

**Objective:** Test transformation logic on representative sample before full production load.

**Key Activities:**
- Random sampling (1,000 loans) using `RAND()` function
- Sample representativeness validation (distribution comparison vs. full dataset)
- Field mapping execution (48 fields with transformations)
- Trial reconciliation across multiple dimensions

**Transformations Applied:**
- **Date conversions:** Integer MMYYYY format → SQL DATE type
  - Example: `202501` → `2025-01-01`
- **Code mappings:** Single-character codes → descriptive values
  - Channel: R → Retail, C → Correspondent, B → Broker
  - Loan Purpose: P → Purchase, R → Refinance, C → Cash-Out Refinance
  - Property Type: SF → Single-Family Home, CO → Condominium, etc.
- **Data type conversions:** Integer loan IDs → STRING for compatibility
- **Field renaming:** Source field names → MSP naming conventions

**Trial Reconciliation Results:**
- ✅ Row count: 1,000 = 1,000 (zero variance)
- ✅ Monetary totals: $0.00 variance on UPB fields
- ✅ Code mappings: 100% accuracy
- ✅ Date conversions: Validated via spot-check
- ✅ 5-loan field-by-field manual validation: Zero discrepancies

---

### **Phase 3: Production Load (Full 388,622 loans)**

**Objective:** Execute full-scale conversion using validated transformation logic.

**Key Activities:**
- Applied tested transformation logic to complete dataset
- Loaded all 388,622 loans into simulated MSP production environment
- Comprehensive multi-layer reconciliation

**Production Reconciliation Results:**
- ✅ Row count: 388,622 = 388,622 (zero variance)
- ✅ Original UPB total: Exact match
- ✅ Current UPB total: Exact match
- ✅ Field-level completeness: Preserved across all 48 fields
- ✅ Code distribution: Source vs. target distributions match
- ✅ Date logic validation: Zero invalid date sequences
- ✅ Numeric range validation: Zero outliers introduced

---

## Key Technical Skills Demonstrated

### **SQL Proficiency**
- Complex data profiling queries (aggregations, distributions, null analysis)
- Advanced transformations (CASE statements, PARSE_DATE, LPAD, CAST)
- Multi-table reconciliation queries (UNION ALL, aggregate comparisons)
- Random sampling and statistical validation
- Data quality checks (range validation, referential integrity)

### **Data Integration Best Practices**
- Industry-standard TOS workflow (trial balance → production load)
- Representative sampling methodology
- Multi-layer reconciliation framework:
  - Row-level (counts)
  - Monetary (balances)
  - Field-level (completeness)
  - Code-level (mappings)
  - Spot-check (manual validation)
- Comprehensive documentation and audit trail

### **Mortgage Domain Knowledge**
- Understanding of critical servicing fields (UPB, escrow, delinquency status, investor codes)
- Loan lifecycle data structures (origination → servicing → payoff)
- Regulatory data requirements (borrower demographics, property information, payment history)

---

## Results Summary

| Metric | Value |
|--------|-------|
| **Total Loans Migrated** | 388,622 |
| **Source Fields** | 110 |
| **Target Fields Migrated** | 48 |
| **Trial Sample Size** | 1,000 loans |
| **Trial Reconciliation Status** | ✅ PASSED - Zero Variances |
| **Production Reconciliation Status** | ✅ PASSED - Zero Variances |
| **Data Quality Exceptions** | 0 Critical Issues |
| **Row Count Variance** | 0 |
| **Monetary Variance (UPB)** | $0.00 |

---

## Key Learnings & Takeaways

### **Challenges Encountered**
1. **Date Format Complexity:** Source dates stored as integers (MMYYYY) required careful conversion using `PARSE_DATE` with `LPAD` to handle varying string lengths
2. **Composite Primary Key:** Standard duplicate checks insufficient due to longitudinal data structure; required concatenated key validation
3. **Code Mapping Completeness:** Ensured all source codes had corresponding target values to prevent NULL mappings

### **Best Practices Applied**
- **Representative Sampling:** Validated trial sample distribution matched full dataset before testing transformations
- **Iterative Validation:** Trial balance caught potential issues before production load
- **Multi-Dimensional Reconciliation:** Combined row counts, monetary totals, code distributions, and spot-checks for comprehensive validation
- **Documentation Discipline:** Maintained detailed audit trail of all queries, decisions, and results

### **Industry Relevance**
This project mirrors real-world mortgage servicing conversions where:
- Data accuracy is non-negotiable (affects borrower payments, investor reporting, regulatory compliance)
- Zero-variance reconciliation is the standard (even $0.01 discrepancies are unacceptable)
- Thorough validation prevents operational disruptions and borrower impact

---

## Documentation

Comprehensive project documentation is available in the `/documentation` folder:

**Excel Documentation Includes:**
- Executive summary with key metrics
- Data profiling results and portfolio composition analysis
- Field mapping table (48 fields with transformation logic)
- Trial balance reconciliation results
- Production reconciliation results
- Exception report (data quality issues and resolutions)
- Complete SQL query log
- Lessons learned and process recommendations

---

## Future Enhancements

- **Escrow Account Reconciliation:** Add escrow balance validation (taxes/insurance tracking)
- **Payment History Validation:** Implement delinquency status verification logic
- **Investor Segmentation Analysis:** Break out reconciliation by investor type (Fannie Mae, Freddie Mac, Portfolio)
- **Automated Data Quality Checks:** Build reusable SQL functions for profiling
- **Performance Optimization:** Analyze query execution times for large-scale datasets

---

## About This Project

This portfolio project was developed to demonstrate technical proficiency for **Data Integration Analyst** roles in the mortgage servicing industry. It showcases:
- End-to-end conversion workflow execution
- SQL-based data transformation and validation
- Industry-standard reconciliation methodologies
- Professional documentation practices
- Mortgage domain knowledge

---

## Contact

**Krastiu Dimov**  
📧 kdimov2798@gmail.com  
💼 [LinkedIn](https://www.linkedin.com/in/krastiudimov)  
🌐 [Portfolio](https://kdimov2798.github.io/KDimovWebsite.github.io/)  
💻 [GitHub](https://github.com/kdimov2798)

---

## Acknowledgments

- **Data Source:** Fannie Mae Single Family Loan Performance Data
- **Industry Standards:** MISMO Servicing Transfer Catalog best practices
- **Technology:** Google Cloud Platform (BigQuery)
