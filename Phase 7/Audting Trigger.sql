CREATE OR REPLACE TRIGGER audit_trigger  
AFTER UPDATE ON Customer  
FOR EACH ROW  
BEGIN  
  INSERT INTO AuditLog (action, table_name, old_value, new_value, modified_by, timestamp)  
  VALUES ('UPDATE', 'Customer', :OLD.name, :NEW.name, USER, SYSDATE);  
END;  
/  
