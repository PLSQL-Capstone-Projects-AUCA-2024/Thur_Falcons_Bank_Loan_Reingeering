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

###Customer Table

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
# Use Case Scenarios
## Scenario 1:
### Loan Application Submission
###A customer submits a loan application.
###The system performs credit checks and processes the application.
###If approved, the loan details are stored in the Loan table.
##Scenario 2: 
### Feedback Collection
### Customers provide feedback after receiving a loan.
### The feedback is analyzed to improve service.
# Future Enhancements
### Integration with AI-powered credit scoring systems.
### Implementation of machine learning for customer feedback analysis.
### Deployment of mobile and web interfaces for self-service.
