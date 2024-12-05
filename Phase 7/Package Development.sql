CREATE OR REPLACE PACKAGE loan_package IS  
  PROCEDURE approve_loan(p_applicationID INT);  
  FUNCTION get_loan_status(p_loanID INT) RETURN VARCHAR2;  
END loan_package;  
/  

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
