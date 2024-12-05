Thur Falcons Bank Loan Origination Process Re-Engineering
Welcome to the Thur Falcons Bank Loan Origination Process Re-Engineering project. This repository contains the complete implementation of a re-engineered loan origination process for BPR Bank. The goal is to streamline loan application processing, improve customer satisfaction, and minimize financial losses using optimized workflows and database integration.

Project Overview
The project aims to address customer dissatisfaction and financial losses resulting from the lengthy loan application process at BPR Bank. By re-engineering the loan origination process, we strive to:

Reduce the average time between loan application and funding (ATBLA) to 2 hours.
Increase the Customer Satisfaction Index (CSI) to 80%.
Minimize financial losses from abandoned applications.
Features
Automated Loan Application Processing: Reduces manual interventions and speeds up credit checks and compliance verification.
Instant Notifications: Provides real-time updates to customers about application status.
Feedback Mechanism: Tracks customer satisfaction to drive continuous improvement.
Integrated MIS Framework: Aligns with the bank's management information systems for efficient operations.
Key Components
Loan Application Workflow: Re-engineered processes for faster approval and funding.
Data Model: Optimized database schema with key entities like customers, branches, loans, financial losses, feedback, and application processing.
Automation: Integration of automated credit checks, compliance validation, and instant funding mechanisms.
Table of Contents
System Architecture
Database Design
Entity Relationship Diagram
Tables and Relationships
Database Scripts
Create Tables
Insert Sample Data
Pluggable Database Creation
Use Case Scenarios
How to Contribute
License
System Architecture
This project integrates various components to streamline the loan origination process:

Frontend: Interfaces for customers and bank employees.
Backend: Implements the business logic and API endpoints.
Database: Stores and manages data with relationships and constraints.
Database Design
Entity Relationship Diagram
The database model includes key entities like:

Customers
Loan Applications
Loans
Financial Losses
Feedback
Branches
Application Processing
Tables and Relationships
Each table is carefully designed to ensure data integrity and efficiency. Below are the SQL scripts for creating the tables:

Database Scripts
Create Tables
1. Branch Table
sql
Copy code
CREATE TABLE Branch (
    branchID INT PRIMARY KEY,
    branchName VARCHAR(100) NOT NULL,
    location VARCHAR(100) NOT NULL,
    phone VARCHAR(20) NOT NULL
);
2. Customer Table
sql
Copy code
CREATE TABLE Customer (
    customerID INT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    address VARCHAR(255) NOT NULL,
    phone VARCHAR(20) NOT NULL,
    email VARCHAR(100) NOT NULL,
    nationalID VARCHAR(20) UNIQUE NOT NULL,
    CSI_score INT NOT NULL
);
3. LoanApplication Table
sql
Copy code
CREATE TABLE LoanApplication (
    applicationID INT PRIMARY KEY,
    customerID INT,
    loanAmount DECIMAL(15, 2) NOT NULL,
    applicationDate DATE NOT NULL,
    status VARCHAR(50) NOT NULL,
    branchID INT,
    documentLinks TEXT,
    CONSTRAINT fk_LoanApplication_customer FOREIGN KEY (customerID) REFERENCES Customer(customerID),
    CONSTRAINT fk_LoanApplication_branch FOREIGN KEY (branchID) REFERENCES Branch(branchID)
);
4. Loan Table
sql
Copy code
CREATE TABLE Loan (
    loanID INT PRIMARY KEY,
    applicationID INT,
    loanAmount DECIMAL(15, 2) NOT NULL,
    interestRate FLOAT NOT NULL,
    termMonths INT NOT NULL,
    approvalDate DATE NOT NULL,
    fundingDate DATE NOT NULL,
    loanStatus VARCHAR(50) NOT NULL,
    CONSTRAINT fk_loan_loanApplication FOREIGN KEY (applicationID) REFERENCES LoanApplication(applicationID)
);
5. Application Processing Table
sql
Copy code
CREATE TABLE ApplicationProcessing (
    processID INT PRIMARY KEY,
    applicationID INT,
    stepName VARCHAR(50) NOT NULL,
    startTime TIMESTAMP NOT NULL,
    endTime TIMESTAMP NOT NULL,
    status VARCHAR(50) NOT NULL,
    CONSTRAINT fk_ApplicationProcessing_loanApplication FOREIGN KEY (applicationID) REFERENCES LoanApplication(applicationID)
);
6. Feedback Table
sql
Copy code
CREATE TABLE Feedback (
    feedbackID INT PRIMARY KEY,
    customerID INT,
    loanID INT,
    score INT NOT NULL,
    comments VARCHAR(255),
    feedbackDate DATE NOT NULL,
    CONSTRAINT fk_feedback_customer FOREIGN KEY (customerID) REFERENCES Customer(customerID),
    CONSTRAINT fk_feedback_loan FOREIGN KEY (loanID) REFERENCES Loan(loanID)
);
7. Financial Loss Table
sql
Copy code
CREATE TABLE FinancialLoss (
    lossID INT PRIMARY KEY,
    applicationID INT,
    lossAmount DECIMAL(15, 2) NOT NULL,
    reason VARCHAR(255),
    recordDate DATE NOT NULL,
    CONSTRAINT fk_financialLoss_loanApplication FOREIGN KEY (applicationID) REFERENCES LoanApplication(applicationID)
);
Insert Sample Data
Here's how to insert sample data into the tables:

sql
Copy code
-- Insert sample data for Branch
INSERT INTO Branch (branchID, branchName, location, phone) VALUES
(1, 'Kigali Branch', 'Kigali City', '+250788000001');

-- Insert sample data for Customer
INSERT INTO Customer (customerID, name, address, phone, email, nationalID, CSI_score) VALUES
(1, 'John Doe', 'Kigali', '+250788000002', 'john.doe@example.com', '119900112233', 70);
Pluggable Database Creation
To create a pluggable database for this project, use the following Oracle SQL commands:

sql
Copy code
-- Create Pluggable Database
CREATE PLUGGABLE DATABASE Thur_Falcons_PDB
  ADMIN USER admin IDENTIFIED BY admin_password
  ROLES = (DBA)
  DEFAULT TABLESPACE users
  DATAFILE '/u01/app/oracle/oradata/thursday/pdb1/users01.dbf' SIZE 500M AUTOEXTEND ON;

-- Open the Pluggable Database
ALTER PLUGGABLE DATABASE Thur_Falcons_PDB OPEN;
Use Case Scenarios
1. Loan Application Submission
A customer submits a loan application at a branch or digitally. The application progresses through automated processing steps for approval.

2. Customer Feedback Collection
Customers provide feedback after their loan applications are processed, aiding in service improvements.

3. Analyzing Financial Losses
Rejected or abandoned applications are recorded in the financial loss table to assess risk and improve policies.

How to Contribute
Fork the repository.
Clone your forked repository.
Make your changes and commit them.
Push your changes to your forked repository.
Open a pull request to the main branch.
