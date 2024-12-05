# Bank Loan Origination Process Re-engineering

This project re-engineers the **Loan Origination Process** for **BPR Bank**, focusing on improving efficiency, reducing processing times, and enhancing customer satisfaction. By automating workflows and streamlining the loan application journey, we aim to reduce financial losses from abandoned applications and achieve better Customer Satisfaction Index (CSI) scores.

GitHub Repository: [Thur_Falcons_Bank_Loan_Reingeering](https://github.com/PLSQL-Capstone-Projects-AUCA-2024/Thur_Falcons_Bank_Loan_Reingeering)

---

## Table of Contents
1. [Project Overview](#project-overview)
2. [Objectives](#objectives)
3. [Project Scope](#project-scope)
4. [Entity Relationship and Data Model](#entity-relationship-and-data-model)
5. [Database Creation and SQL Code](#database-creation-and-sql-code)
6. [Use Case Scenarios](#use-case-scenarios)
7. [Future Enhancements](#future-enhancements)
8. [Contributing](#contributing)
9. [License](#license)

---

## Project Overview

The **Bank Loan Origination Process Re-engineering** project addresses customer dissatisfaction and financial losses caused by delays in loan application processing. The re-engineered process leverages **automation** to:
- Reduce the **Average Time Between Loan Application and Funding (ATBLA)**.
- Increase the **Customer Satisfaction Index (CSI)**.
- Minimize financial losses from abandoned applications.

---

## Objectives

1. **Reduce ATBLA**: Process and approve loan applications within **2 hours**.
2. **Enhance Customer Satisfaction**: Achieve a **CSI of 80%** by improving process efficiency.
3. **Minimize Financial Losses**: Reduce losses from abandoned applications, currently estimated at **Rwf 40,000,000 annually**.

---

## Project Scope

### Current State (Before Re-engineering)
- Manual, inefficient, and time-consuming processes.
- Low CSI scores due to prolonged delays.
- High financial losses from abandoned applications.

### Future State (After Re-engineering)
- Automated workflows reduce manual interventions.
- Faster application approvals with integrated credit checks and quality control.
- Enhanced customer satisfaction with real-time notifications and feedback.

---

## Entity Relationship and Data Model

The project employs a relational database model. Below are the core entities and their relationships:

- **Customers**: Submit loan applications.
- **Loan Applications**: Track details of customer loan requests.
- **Loans**: Store details of approved loans.
- **Branches**: Represent physical bank locations.
- **Feedback**: Collect customer feedback post-loan approval.
- **Application Processing**: Log each step of the loan application process.
- **Financial Losses**: Track abandoned applications causing financial losses.
- **Credit Checks**: Store results of credit evaluations.

### Entity Relationship Diagram (ERD)
> (Include a link or image to an ERD diagram if possible)

---

## Database Creation and SQL Code

Below are the SQL scripts for creating the database schema, inserting sample data, and setting up a pluggable Oracle database.

## Create Tables

### `Branch` Table
```sql
CREATE TABLE Branch (
  branchID INT PRIMARY KEY,
  branchName VARCHAR(100) NOT NULL,
  location VARCHAR(100) NOT NULL,
  phone VARCHAR(20) NOT NULL
);
```

## Customer Table

```sql
CREATE TABLE Customer (
  customerID INT PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  address VARCHAR(255) NOT NULL,
  phone VARCHAR(20) NOT NULL,
  email VARCHAR(100) NOT NULL,
  nationalID VARCHAR(20) UNIQUE NOT NULL,
  CSI_score INT NOT NULL
);
```
## LoanApplication Table

```sql
CREATE TABLE LoanApplication (
  applicationID INT PRIMARY KEY,
  customerID INT NOT NULL,
  loanAmount DECIMAL(15, 2) NOT NULL,
  applicationDate DATE NOT NULL,
  status VARCHAR(50) NOT NULL,
  branchID INT NOT NULL,
  documentLinks VARCHAR(255),
  CONSTRAINT fk_LoanApplication_Customer FOREIGN KEY (customerID) REFERENCES Customer(customerID),
  CONSTRAINT fk_LoanApplication_Branch FOREIGN KEY (branchID) REFERENCES Branch(branchID)
);
```
## Loan Table
```sql
CREATE TABLE Loan (
  loanID INT PRIMARY KEY,
  applicationID INT NOT NULL,
  loanAmount DECIMAL(15, 2) NOT NULL,
  interestRate FLOAT NOT NULL,
  termMonths INT NOT NULL,
  approvalDate DATE NOT NULL,
  fundingDate DATE NOT NULL,
  loanStatus VARCHAR(50) NOT NULL,
  CONSTRAINT fk_Loan_Application FOREIGN KEY (applicationID) REFERENCES LoanApplication(applicationID)
);
```
## Feedback Table
```sql
Copy code
CREATE TABLE Feedback (
  feedbackID INT PRIMARY KEY,
  customerID INT NOT NULL,
  loanID INT NOT NULL,
  score INT NOT NULL,
  comments VARCHAR(255),
  feedbackDate DATE NOT NULL,
  CONSTRAINT fk_Feedback_Customer FOREIGN KEY (customerID) REFERENCES Customer(customerID),
  CONSTRAINT fk_Feedback_Loan FOREIGN KEY (loanID) REFERENCES Loan(loanID)
);
```
### Additional Tables
Other tables like ApplicationProcessing, CreditCheck, and FinancialLoss can be similarly defined. See full database schema.

## Insert Sample Data
```sql
INSERT INTO Branch (branchID, branchName, location, phone)
VALUES (1, 'Kigali Branch', 'Kigali, Rwanda', '+250788000000');

INSERT INTO Customer (customerID, name, address, phone, email, nationalID, CSI_score)
VALUES (1, 'John Doe', 'Kigali', '+250788111222', 'johndoe@example.com', '119900123456789', 75);
```
## Create a Pluggable Database
```sql
CREATE PLUGGABLE DATABASE Thur_Falcons_Bank
ADMIN USER admin IDENTIFIED BY Password123
FILE_NAME_CONVERT = ('/u01/app/oracle/oradata/pdbseed/',
                     '/u01/app/oracle/oradata/Thur_Falcons_Bank/');
```

## Problem Statement
### The loan origination process at BPR Bank is inefficient, leading to delays, financial losses, and data inconsistencies. Key challenges include:

##### -Enforcing business rules to prevent invalid loan applications.
##### -Ensuring transactional integrity during loan approval.
##### -Automating workflows to reduce manual interventions.
##### -Monitoring sensitive data changes for accountability.
## Justification for Advanced Techniques
#### -Triggers: Automate business rules and workflows, ensuring real-time enforcement of data integrity.
#### -Cursors: Facilitate row-by-row processing for scenarios like batch updates or approval.
#### -Functions: Modularize calculations (e.g., interest rate computation).
#### -Packages: Enhance code organization, reusability, and security.
#### -Auditing: Track user actions and log sensitive data changes, ensuring accountability.
#Features and Implementation
## Trigger Implementation
#### Triggers are used to enforce business rules, maintain data integrity, and automate workflows.

## Simple Triggers
### BEFORE INSERT trigger ensures no loan is processed without a valid credit check.
```sql
CREATE OR REPLACE TRIGGER before_loan_insert  
BEFORE INSERT ON loan  
FOR EACH ROW  
BEGIN  
  IF NOT EXISTS (SELECT 1 FROM CreditCheck WHERE applicationID = :NEW.applicationID) THEN  
    RAISE_APPLICATION_ERROR(-20001, 'Loan cannot be processed without a credit check.');  
  END IF;  
END;  
/  
```
## Compound Triggers
A compound trigger ensures transactional consistency for multi-row operations in the LoanApplication table.

```sql
CREATE OR REPLACE TRIGGER loan_application_trigger  
FOR INSERT OR UPDATE OR DELETE ON LoanApplication  
COMPOUND TRIGGER  

  TYPE application_row IS RECORD (  
    applicationID LoanApplication.applicationID%TYPE,  
    status LoanApplication.status%TYPE  
  );
```  
  ## application_changes SYS_REFCURSOR;  

#### BEFORE EACH ROW IS  
BEGIN  
  -- Audit changes before any row modification  
 ```sql
 INSERT INTO AuditLog (action, applicationID, old_status, new_status, timestamp)  
  VALUES ('BEFORE UPDATE', :OLD.applicationID, :OLD.status, :NEW.status, SYSDATE);  
END BEFORE EACH ROW;
```  

```sql
 AFTER EACH ROW IS  
BEGIN  
  -- Process status changes after the operation  
  IF :NEW.status = 'Approved' THEN  
    ```
    INSERT INTO Loan (applicationID, loanAmount, approvalDate, loanStatus)  
    VALUES (:NEW.applicationID, :NEW.loanAmount, SYSDATE, 'Active');  
  END IF;  
END AFTER EACH ROW;  

END loan_application_trigger;  
/  

```
### Cursor Usage
Explicit cursors are implemented for batch updates and row-by-row processing scenarios.

```sql
CREATE OR REPLACE PROCEDURE update_loan_status IS  
  CURSOR loan_cursor IS  
    SELECT loanID, loanStatus FROM Loan WHERE loanStatus = 'Pending';  
  loan_rec loan_cursor%ROWTYPE;  
BEGIN  
  OPEN loan_cursor;  
  LOOP  
    FETCH loan_cursor INTO loan_rec;  
    EXIT WHEN loan_cursor%NOTFOUND;  

    UPDATE Loan SET loanStatus = 'Processed' WHERE loanID = loan_rec.loanID;  
  END LOOP;  
  CLOSE loan_cursor;  
END;  
/  
```
### Attributes and Functions
Functions encapsulate logic for specific tasks like interest rate calculation.

```sql
CREATE OR REPLACE FUNCTION calculate_interest(  
  p_loanAmount IN NUMBER,  
  p_interestRate IN FLOAT  
) RETURN NUMBER IS  
BEGIN  
  RETURN (p_loanAmount * p_interestRate) / 100;  
END calculate_interest;  
/  
```
### Using %ROWTYPE for dynamic data processing:
```sql
DECLARE  
  loan_rec Loan%ROWTYPE;  
BEGIN  
  SELECT * INTO loan_rec FROM Loan WHERE loanID = 101;  
  DBMS_OUTPUT.PUT_LINE('Loan Amount: ' || loan_rec.loanAmount);  
END;  
/  
```
### Package Development
Packages organize related procedures and functions.

```sql
CREATE OR REPLACE PACKAGE loan_package IS  
  PROCEDURE approve_loan(p_applicationID INT);  
  FUNCTION get_loan_status(p_loanID INT) RETURN VARCHAR2;  
END loan_package;
```  
  
```sql
CREATE OR REPLACE PACKAGE BODY loan_package IS  
  PROCEDURE approve_loan(p_applicationID INT) IS  
  BEGIN  
    UPDATE LoanApplication  
    SET status = 'Approved'  
    WHERE applicationID = p_applicationID;  
  END; 

  FUNCTION get_loan_status(p_loanID INT) RETURN VARCHAR2 IS  
    loan_status VARCHAR2(50);  
  BEGIN  
    SELECT loanStatus INTO loan_status FROM Loan WHERE loanID = p_loanID;  
    RETURN loan_status;  
  END;  
END loan_package;  
/  

```
### Auditing Mechanisms
Auditing ensures tracking of sensitive data changes.

```sql
CREATE OR REPLACE TRIGGER audit_trigger  
AFTER UPDATE ON Customer  
FOR EACH ROW  
BEGIN  
  INSERT INTO AuditLog (action, table_name, old_value, new_value, modified_by, timestamp)  
  VALUES ('UPDATE', 'Customer', :OLD.name, :NEW.name, USER, SYSDATE);  
END;  
/  
```
## Use Case Scenarios
### Scenario 1:
##### Loan Application Submission
##### 1.customer submits a loan application.
##### 2.The system performs credit checks and processes the application.
##### 3.If approved, the loan details are stored in the Loan table.
### Scenario 2: 
##### 1.Feedback Collection
##### 2.Customers provide feedback after receiving a loan.
##### 3.The feedback is analyzed to improve service.
## Future Enhancements
##### 1.Integration with AI-powered credit scoring systems.
###### 2.Implementation of machine learning for customer feedback analysis.
###### 3.Deployment of mobile and web interfaces for self-service.



## Scope and Limitations
### Scope
##### 1.Enforcing business rules through triggers.
##### 2.Modularizing logic with functions and packages.
##### 3.Automating workflows with cursors and triggers.
#### 4.Monitoring database activity via auditing.
##Limitations
##### Complex triggers may impact performance.
##### Explicit cursors are less efficient for bulk operations.
##### Documentation and Demonstration
## Testing Plan
##### Validate triggers by simulating valid and invalid transactions.
##### Test functions with edge cases for interest rate computation.
##### Verify cursor-based batch updates.
##### Demonstrate audit logs for all sensitive data changes.
## Code Implementation
####Full SQL scripts for table creation, data insertion, and PL/SQL components can be found on GitHub:


Author: Thur Falcons Team
Year: 2024
