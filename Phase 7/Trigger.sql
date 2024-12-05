CREATE OR REPLACE TRIGGER before_loan_insert  
BEFORE INSERT ON loan  
FOR EACH ROW  
BEGIN  
  IF NOT EXISTS (SELECT 1 FROM CreditCheck WHERE applicationID = :NEW.applicationID) THEN  
    RAISE_APPLICATION_ERROR(-20001, 'Loan cannot be processed without a credit check.');  
  END IF;  
END;  
/  


-- Compound triggers

CREATE OR REPLACE TRIGGER loan_application_trigger  
FOR INSERT OR UPDATE OR DELETE ON LoanApplication  
COMPOUND TRIGGER  

  TYPE application_row IS RECORD (  
    applicationID LoanApplication.applicationID%TYPE,  
    status LoanApplication.status%TYPE  
  );  
  application_changes SYS_REFCURSOR;  

BEFORE EACH ROW IS  
BEGIN  
  -- Audit changes before any row modification  
  INSERT INTO AuditLog (action, applicationID, old_status, new_status, timestamp)  
  VALUES ('BEFORE UPDATE', :OLD.applicationID, :OLD.status, :NEW.status, SYSDATE);  
END BEFORE EACH ROW;  

AFTER EACH ROW IS  
BEGIN  
  -- Process status changes after the operation  
  IF :NEW.status = 'Approved' THEN  
    INSERT INTO Loan (applicationID, loanAmount, approvalDate, loanStatus)  
    VALUES (:NEW.applicationID, :NEW.loanAmount, SYSDATE, 'Active');  
  END IF;  
END AFTER EACH ROW;  

END loan_application_trigger;  
/  
