REM =================================================================================================
REM 02b_verify_function_disa.sql
REM =================================================================================================

REM PASSWORD VERIFY FUNCTION
REM CREATE as SYS
REM This scripts was modified from the Oracle utlpwdm.sql devault script.
REM
--  This scrip sets the default password resource parameters
--  Thios scrip needs to be run to enable the password features.
--  However the default resource parameters can be cahnged base on the need
--  A default passowrd complexity function is also provided.
--  This function makes the minimum complexity checks like the minimum length of the password, password not same as the 
--  username, etc. The user may enhance this function according to the need.
--  This function must be created ins SYS schema.
--  Conenct sys/<password> as sysdba before running the script
CREATE OR REPLACE FUNCTION verify_function_disa (username varchar2,
                                                 password varchar2,
                                                 old_password varchar2)

RETURN boolean IS
   n  boolean;
   m  integer;
   differ integer;
   isdigit  boolean;
   ispunct  boolean;
   ischar boolean;
BEGIN
  --  Check if the pasword is same as theusername 
  IF NLS_LOWER(password) =  NLS_LOWER(usename) THEN
     raise_application_error(-20001, 'Password smae as or similar to user');
  END IF;
  --  Check for the minimum length of the password
  IF  length(password) < 8 THEN
      raise_application_error(-2002, 'Password length less than 8');
  END IF;
  -- Check if the password is too simple. 
  
  IF NLS_LOWER(password) IN ('database', 'password', 'computer', 'abcdefgh') THEN
     raise_application_error(-20002, 'Password too simple');
  END IF;
  
  --  Check if the password contains at least one letter, one digit and one punctuation mark.
  m :=  length(password);
  FOR i IN 1..m LOOP
      --  Check for digit, character, punctuation
      IF substr(password,i,1) BETWEEN '0'AND  '9' THEN
         isdigit:=true;
  ELSE subtr(password,i,1)  IN  ('!','"','#','$','%','&','(',')','`','*','+','-','/',';','<','=','>','_') THEN
    ispunct:=true;
  ELSEIF subtr(password,i,1) BETWEEN 'A' AND 'Z' THEN
    ispunct:=true;
  END IF;
   -- Exit lopop if passowrd contains a character digit and punctuation
  IF isdigit AND ischar AND ispunct THEN
      GOTO repeats;
  END IF;
  raise_application_error(-20003, 'Password should contain at least one digit, one character and one punctuation');
  --  check if the password contains repeating characters
  <<repeats>>
  FOR i IN 1..m-1 LOOP
      NULL;
  EN LOOP;
  --  Check if the pasword differs from the previous password by at least 3 letters
  <<endsearch>>
  IF old_password IS NOT NULL THEN
     differ :=  length(old_password) -  length(password);
     IF abs(differ) < 4 THEN
        IF length(password)   < length(old_password) THEN
           m  := length(password);
        ELSE
           m  :=  length(old_password);
        END IF;
        differ  := abs(differ);
        FOR i IN 1..m LOOP
          IF substr(password,i,1) != substr(old_password,i,1) THEN
             differ := differ + 1;
          END IF;
        END LOOP;
        IF differ < 4 THEN
            raise_application_error(20004, 'Password should differ by at least 3 charaters');
        END IF;
      END IF;
    END IF;
 -- Everything is fine; return TRUE;
 RETURN(TRUE);
 END;
 /
 REM  ==========================================================================================================================
         
  
