CREATE TABLE bank_loan_data (
    id SERIAL PRIMARY KEY,
    address_state VARCHAR(50),
    application_type VARCHAR(50),
    emp_length VARCHAR(50),
    emp_title VARCHAR(100),
    grade CHAR(1),
    home_ownership VARCHAR(50),
    issue_date DATE,
    last_credit_pull_date DATE,
    last_payment_date DATE,
    loan_status VARCHAR(50),
    next_payment_date DATE,
    member_id BIGINT,
    purpose VARCHAR(100),
    sub_grade VARCHAR(10),
    term VARCHAR(20),
    verification_status VARCHAR(50),
    annual_income NUMERIC(15, 2),
    dti NUMERIC(5, 2),
    installment NUMERIC(10, 2),
    int_rate NUMERIC(5, 2),
    loan_amount NUMERIC(15, 2),
    total_acc INT,
    total_payment NUMERIC(15, 2)
);

-- BANK LOAN REPORT | SUMMARY
-- Total Loan Applications
SELECT COUNT(id) AS Total_Applications 
FROM bank_loan_data;

-- MTD (Month-To-Date) Loan Applications (Assumes current month is December)
SELECT COUNT(id) AS Total_Applications 
FROM bank_loan_data
WHERE EXTRACT(MONTH FROM issue_date) = 12;

-- PMTD (Previous Month-To-Date) Loan Applications (Assumes previous month is November)
SELECT COUNT(id) AS Total_Applications 
FROM bank_loan_data
WHERE EXTRACT(MONTH FROM issue_date) = 11;

-- Total Funded Amount
SELECT SUM(loan_amount) AS Total_Funded_Amount 
FROM bank_loan_data;

-- MTD Total Funded Amount
SELECT SUM(loan_amount) AS Total_Funded_Amount 
FROM bank_loan_data
WHERE EXTRACT(MONTH FROM issue_date) = 12;

-- PMTD Total Funded Amount
SELECT SUM(loan_amount) AS Total_Funded_Amount 
FROM bank_loan_data
WHERE EXTRACT(MONTH FROM issue_date) = 11;

-- Total Amount Received
SELECT SUM(total_payment) AS Total_Amount_Collected 
FROM bank_loan_data;

-- MTD Total Amount Received
SELECT SUM(total_payment) AS Total_Amount_Collected 
FROM bank_loan_data
WHERE EXTRACT(MONTH FROM issue_date) = 12;

-- PMTD Total Amount Received
SELECT SUM(total_payment) AS Total_Amount_Collected 
FROM bank_loan_data
WHERE EXTRACT(MONTH FROM issue_date) = 11;

-- Average Interest Rate
SELECT AVG(int_rate) * 100 AS Avg_Int_Rate 
FROM bank_loan_data;

-- MTD Average Interest Rate
SELECT AVG(int_rate) * 100 AS MTD_Avg_Int_Rate
FROM bank_loan_data
WHERE EXTRACT(MONTH FROM issue_date) = 12;

-- PMTD Average Interest Rate
SELECT AVG(int_rate) * 100 AS PMTD_Avg_Int_Rate
FROM bank_loan_data
WHERE EXTRACT(MONTH FROM issue_date) = 11;

-- Average DTI
SELECT AVG(dti) * 100 AS Avg_DTI
FROM bank_loan_data;

-- MTD Average DTI
SELECT AVG(dti) * 100 AS MTD_Avg_DTI
FROM bank_loan_data
WHERE EXTRACT(MONTH FROM issue_date) = 12;

-- PMTD Average DTI
SELECT AVG(dti) * 100 AS PMTD_Avg_DTI
FROM bank_loan_data
WHERE EXTRACT(MONTH FROM issue_date) = 11;

-- Good Loan Percentage
SELECT
    (COUNT(CASE WHEN loan_status = 'Fully Paid' OR loan_status = 'Current' THEN id END) * 100.0) /
    COUNT(id) AS Good_Loan_Percentage
FROM bank_loan_data;

-- Good Loan Applications
SELECT COUNT(id) AS Good_Loan_Applications
FROM bank_loan_data
WHERE loan_status = 'Fully Paid' OR loan_status = 'Current';

-- Good Loan Funded Amount
SELECT SUM(loan_amount) AS Good_Loan_Funded_Amount
FROM bank_loan_data
WHERE loan_status = 'Fully Paid' OR loan_status = 'Current';

-- Good Loan Amount Received
SELECT SUM(total_payment) AS Good_Loan_Amount_Received
FROM bank_loan_data
WHERE loan_status = 'Fully Paid' OR loan_status = 'Current';


-- Bad Loan Percentage
SELECT
    (COUNT(CASE WHEN loan_status = 'Charged Off' THEN id END) * 100.0) /
    COUNT(id) AS Bad_Loan_Percentage
FROM bank_loan_data;

-- Bad Loan Applications
SELECT COUNT(id) AS Bad_Loan_Applications
FROM bank_loan_data
WHERE loan_status = 'Charged Off';

-- Bad Loan Funded Amount
SELECT SUM(loan_amount) AS Bad_Loan_Funded_Amount
FROM bank_loan_data
WHERE loan_status = 'Charged Off';

-- Bad Loan Amount Received
SELECT SUM(total_payment) AS Bad_Loan_Amount_Received
FROM bank_loan_data
WHERE loan_status = 'Charged Off';

-- Loan Status Overview
SELECT
    loan_status,
    COUNT(id) AS LoanCount,
    SUM(total_payment) AS Total_Amount_Received,
    SUM(loan_amount) AS Total_Funded_Amount,
    AVG(int_rate) * 100 AS Interest_Rate,
    AVG(dti) * 100 AS DTI
FROM bank_loan_data
GROUP BY loan_status;

-- MTD Loan Status Metrics
SELECT 
    loan_status, 
    SUM(total_payment) AS MTD_Total_Amount_Received, 
    SUM(loan_amount) AS MTD_Total_Funded_Amount
FROM bank_loan_data
WHERE EXTRACT(MONTH FROM issue_date) = 12
GROUP BY loan_status;

-- Month
SELECT 
    EXTRACT(MONTH FROM issue_date) AS Month_Number, 
    TO_CHAR(issue_date, 'Month') AS Month_Name, 
    COUNT(id) AS Total_Loan_Applications,
    SUM(loan_amount) AS Total_Funded_Amount,
    SUM(total_payment) AS Total_Amount_Received
FROM bank_loan_data
GROUP BY EXTRACT(MONTH FROM issue_date), TO_CHAR(issue_date, 'Month')
ORDER BY Month_Number;

--STATE
SELECT 
    address_state AS State, 
    COUNT(id) AS Total_Loan_Applications,
    SUM(loan_amount) AS Total_Funded_Amount,
    SUM(total_payment) AS Total_Amount_Received
FROM bank_loan_data
GROUP BY address_state
ORDER BY address_state;

-- TERM
SELECT 
    term AS Term, 
    COUNT(id) AS Total_Loan_Applications,
    SUM(loan_amount) AS Total_Funded_Amount,
    SUM(total_payment) AS Total_Amount_Received
FROM bank_loan_data
GROUP BY term
ORDER BY term;

-- EMPLOYEE LENGTH
SELECT 
    emp_length AS Employee_Length, 
    COUNT(id) AS Total_Loan_Applications,
    SUM(loan_amount) AS Total_Funded_Amount,
    SUM(total_payment) AS Total_Amount_Received
FROM bank_loan_data
GROUP BY emp_length
ORDER BY emp_length;

-- PURPOSE
SELECT 
    purpose AS Purpose, 
    COUNT(id) AS Total_Loan_Applications,
    SUM(loan_amount) AS Total_Funded_Amount,
    SUM(total_payment) AS Total_Amount_Received
FROM bank_loan_data
GROUP BY purpose
ORDER BY purpose;

-- HOME OWNERSHIP
SELECT 
    home_ownership AS Home_Ownership, 
    COUNT(id) AS Total_Loan_Applications,
    SUM(loan_amount) AS Total_Funded_Amount,
    SUM(total_payment) AS Total_Amount_Received
FROM bank_loan_data
GROUP BY home_ownership
ORDER BY home_ownership;






