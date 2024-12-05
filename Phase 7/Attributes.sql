CREATE OR REPLACE FUNCTION calculate_interest(  
  p_loanAmount IN NUMBER,  
  p_interestRate IN FLOAT  
) RETURN NUMBER IS  
BEGIN  
  RETURN (p_loanAmount * p_interestRate) / 100;  
END calculate_interest;  
/  
