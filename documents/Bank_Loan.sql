USE Bank_Loan_DB
SELECT * FROM Bank_loan_data

-- Total Loan Applictions:
SELECT COUNT(id)  AS Total_Loan_Applictions FROM Bank_loan_data

-- MTD Loan Applications
SELECT COUNT(id)  AS MTD_Total_Loan_Applictions FROM Bank_loan_data
WHERE MONTH(issue_date) = 12 AND YEAR(issue_date) = 2021

-- PMTD Loan Applications
SELECT COUNT(id)  AS PMTD_Total_Loan_Applictions FROM Bank_loan_data
WHERE MONTH(issue_date) = 11 AND YEAR(issue_date) = 2021

-- Total Funded Amount
SELECT SUM(loan_amount) AS Total_Funded_Amount FROM Bank_loan_data

--MTD Total Funded Amount
SELECT SUM(loan_amount) AS MTD_Total_Funded_Amount FROM Bank_loan_data
WHERE MONTH(issue_date) = 12 AND YEAR(issue_date) = 2021

--PMTD Total Funded Amount
SELECT SUM(loan_amount) AS PMTD_Total_Funded_Amount FROM Bank_loan_data
WHERE MONTH(issue_date) = 11 AND YEAR(issue_date) = 2021

--Total Amount Received
SELECT SUM(total_payment) AS Total_Amount_Received FROM Bank_loan_data

--MTD Total Amount Received
SELECT SUM(total_payment) AS MTD_Total_Amount_Received FROM Bank_loan_data 
WHERE MONTH(issue_date) = 12 AND YEAR(issue_date) = 2021

--PMTD Total Amount Received:
SELECT SUM(total_payment) AS PMTD_Total_Amount_Received FROM Bank_loan_data
WHERE MONTH(issue_date) = 11 AND YEAR(issue_date) = 2021

-- Average Interest Rate:
SELECT ROUND(AVG(int_rate),5)*100 AS Avg_Interest_Rate FROM Bank_loan_data

-- MTD Average Interest Rate:
SELECT ROUND(AVG(int_rate),5)*100 AS MTD_Avg_Interest_Rate FROM Bank_loan_data
WHERE MONTH(issue_date) = 12 AND YEAR(issue_date) = 2021

--PMTD Average Interest Rate:
SELECT ROUND(AVG(int_rate),5)*100 AS PMTD_Avg_Interest_Rate FROM Bank_loan_data
WHERE MONTH(issue_date) = 11 AND YEAR(issue_date) = 2021

-- Avg DTI
SELECT ROUND(AVG(dti),4)*100 AS Avg_DTI FROM Bank_loan_data

-- MTD Avg DTI
SELECT ROUND(AVG(dti),4)*100 AS MTD_Avg_DTI FROM Bank_loan_data
WHERE MONTH(issue_date) = 12 AND YEAR(issue_date) = 2021

-- PMTD Avg DTI
SELECT ROUND(AVG(dti),4)*100 AS PMTD_Avg_DTI FROM Bank_loan_data
WHERE MONTH(issue_date) = 11 AND YEAR(issue_date) = 2021

--Good Loan Percentage 
SELECT (COUNT (CASE
				WHEN loan_status = 'Fully Paid' OR loan_status = 'Current'
				THEN id END)*100) / COUNT(id) AS Good_Loan_Percentage
From Bank_loan_data
		
--Good Loan Applications
SELECT COUNT(id) AS Good_Loan_Applications FROM Bank_loan_data
WHERE loan_status = 'Fully Paid' OR loan_status = 'Current'

--Good Loan Funded Amount
SELECT SUM(loan_amount) AS Good_Loan_Funded_Amount FROM Bank_loan_data
WHERE loan_status IN('Fully Paid','Current')

--Good Loan Amount Received
SELECT SUM(total_payment) AS Good_Loan_Amount_Received FROM Bank_loan_data
WHERE loan_status IN('Fully Paid','Current')

--Bad Loan Percentage
SELECT (COUNT(CASE
				WHEN loan_status = 'Charged off' THEN id END)*100.0)/
				COUNT(id) AS Bad_Loan_Percentage
FROM Bank_loan_data

--Bad Loan Applications
SELECT COUNT(id) AS Bad_Loan_Applications FROM Bank_loan_data
WHERE loan_status = 'Charged Off'

-- Bad Loan Funded Amount
SELECT SUM(loan_amount) AS Bad_Loan_Funded_amount FROM Bank_loan_data
WHERE loan_status = 'Charged Off'

--Bad Loan Amount Received
SELECT SUM(total_payment) AS Bad_Loan_amount_received FROM Bank_loan_data
WHERE loan_status = 'Charged Off'

-- LOAN STATUS
SELECT loan_status,
        COUNT(id) AS Total_Loan_Applications,
        SUM(total_payment) AS Total_Amount_Received,
        SUM(loan_amount) AS Total_Funded_Amount,
        AVG(int_rate * 100) AS Interest_Rate,
        AVG(dti * 100) AS DTI
    FROM
        Bank_loan_data
	GROUP BY
        loan_status

-- MTD_Total_Amount_Received & MTD_Total_Funded_Amount 
SELECT 
	loan_status, 
	SUM(total_payment) AS MTD_Total_Amount_Received, 
	SUM(loan_amount) AS MTD_Total_Funded_Amount 
FROM Bank_loan_data
WHERE MONTH(issue_date) = 12 
GROUP BY loan_status

-- Month
SELECT 
	MONTH(issue_date) AS Month_Number, 
	DATENAME(MONTH, issue_date) AS Month_Name, 
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM Bank_loan_data
GROUP BY MONTH(issue_date), DATENAME(MONTH, issue_date)
ORDER BY MONTH(issue_date)
   
-- State :
SELECT 
	address_state AS State, 
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM Bank_loan_data
GROUP BY address_state
ORDER BY address_state

--TERM
SELECT 
	term AS Term, 
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM Bank_loan_data
GROUP BY term
ORDER BY term

-- EMPLOYEE LENGTH
SELECT 
	emp_length AS Employee_Length, 
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM Bank_loan_data
GROUP BY emp_length
ORDER BY emp_length

--PURPOSE
SELECT 
	purpose AS PURPOSE, 
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM Bank_loan_data
GROUP BY purpose
ORDER BY purpose

--HOME OWNERSHIP
SELECT 
	home_ownership AS Home_Ownership, 
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM Bank_loan_data
GROUP BY home_ownership
ORDER BY home_ownership

--For e.g
--See the results when we hit the Grade A in the filters for dashboards.
SELECT 
	purpose AS PURPOSE, 
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM bank_loan_data
WHERE grade = 'A'
GROUP BY purpose
ORDER BY purpose


