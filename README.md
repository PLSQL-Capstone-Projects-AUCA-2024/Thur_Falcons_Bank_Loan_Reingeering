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

### 1. Create Tables

#### `Branch` Table
```sql
CREATE TABLE Branch (
  branchID INT PRIMARY KEY,
  branchName VARCHAR(100) NOT NULL,
  location VARCHAR(100) NOT NULL,
  phone VARCHAR(20) NOT NULL
);

###Customer Table


CREATE TABLE Customer (
  customerID INT PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  address VARCHAR(255) NOT NULL,
  phone VARCHAR(20) NOT NULL,
  email VARCHAR(100) NOT NULL,
  nationalID VARCHAR(20) UNIQUE NOT NULL,
  CSI_score INT NOT NULL
);
