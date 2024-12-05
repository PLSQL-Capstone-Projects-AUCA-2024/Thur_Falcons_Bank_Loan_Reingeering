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
