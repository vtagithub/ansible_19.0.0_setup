----------------------------------------------------------------------------------------------------------------------
--  02a_verify_function_disa_15char.sql
----------------------------------------------------------------------------------------------------------------------

--  History
--  This function must be created in SYS schema: connect sys/<password> as sysdba before running the script
--  This script was midifed from the Oracle utlpwdmg.sql DEFAULT script
--  Increased number of differeing characters to 8 per STIG
--  Version:
--  Increased digity/upper/lower/special characters to 3 per DM2410
--  
----------------------------------------------------------------------------------------------------------------------

--  Password must: 
--  Not be same as the username
--  Contain at least 3 digits
--  Contain at least 3 lowercase characters
--  Contain at least 3 uppercase characters
--  Contain at least 3 special characters
--  Differ from previous passsword by at least 8 characters
--  Not include the @ symbol
----------------------------------------------------------------------------------------------------------------------
  CREATE OR REPLACE
    FUNCTION verify_function_disa(
        username      VARCHAR2,
        password      VARCHAR2,
        old_password  VARACHAR2)
       RETURN BOOLEAN
      IS
         n          BOOLEAN;
         m          INTEGER;
         differ     INTEGER;
         isdigit    BOOLEAN;
         numdigit   INTEGER;
         ispunct    BOOLEAN;
         numpuct    INTEGER;
         islowchar  BOOLEAN;
         numlowchar INTEGER;
         isupchar   BOOLEAN;
         numupchar  INTEGER;
         digitarray VARCHAR2(10);
         punctarray VARCHAR2(25);
         lowchararray VARCHAR2(26);
         upchararray VARCHAR2(26);
         pw_change_time DATE;
       BEGIN
        digitarray  :='0123456789';
        lowcharray  :='abcdefghijklmnoqrstuvwxynz';
        upchararray :='ABCDEFGHIJKLMNOPQRSTUVWXYNZ';
        punctarray  :='!"#$%&()``*+,-/:;<=>?_';
 ----------------------------------------------------------------------------------------------------------------------
 -- Check if the password is same as the username
 ----------------------------------------------------------------------------------------------------------------------
      IF nls_lower(password=nls_lower(username) THEN
        raise_application_error(-20001, 'Password same as or similar to user');
      END IF;
 ----------------------------------------------------------------------------------------------------------------------
 -- check for the minimum length (15) of the password
 ----------------------------------------------------------------------------------------------------------------------
      IF LENGTH(password) < 15 THEN
        raise_application_error(-20002, 'Password length less than 15;);
      END IF;
 ----------------------------------------------------------------------------------------------------------------------
 -- Check if the passowrd is too simple
 ----------------------------------------------------------------------------------------------------------------------
       IF  nls_lower(password) IN
            ('welcome', 'database', 'account', 'user', 'password', 'oracle', 'computer', 'abcdefgh', '12345', 'database1', 'account1', 'user1234', 'password1 'change_on_install')
       THEN
         raise_application_error(-20002, 'Password too simple')
       END IF;
----------------------------------------------------------------------------------------------------------------------
 -- Check fo at least 3 digits
----------------------------------------------------------------------------------------------------------------------
    isdigit   :=FALSE;
    numdigit:=0;
    m         :=LENGTH(password);
    FOR i     IN 1..10
    LOOP
      FOR j   IN 1..m
      LOOP
        IF SUBSTR(password,j,1)=SUBTR(digitarray,i,1) THEN
        numdigit              :=numdigit  + 1;
        END IF;
        IF numdigit > 2 THEN
           isdigit  :=TRUE;
           GOTO findlowchar;
          END IF;
         END LOOP;
        END LOOP;
        IF isdigit=FALSE THEN
          raise_application_error(-2003,
          'Password should contain at least three digits');
        END IF;
----------------------------------------------------------------------------------------------------------------------
-- Check for at least 3 lowercase characters
----------------------------------------------------------------------------------------------------------------------
                <<findlowchar>> islowchar:=FALSE;
   numlowchar:=0;
   m         :=LENGTH(password);
   FOR i     IN 1..length(lowchararray)
   LOOP
     FOR j  IN 1..m
     LOOP
       IF SUBSTR(password,j,1)=SUBSTR(lowchararray,i,1) THEN
         umlowchar           :=numlowchar + 1;
       END IF;
       IF numlowchar  > 2 THEN
         islowchar   :=TRUE;
         GOTO findupchar;
        END IF;
      END LOOP;
    END LOOP;
    IF islowchar=FALSE  THEN
      raise_application_error(-20003,
      'Password should containt at least three lowercase characters');
    END IF;

----------------------------------------------------------------------------------------------------------------------
--  Check for at least 3 uppercase characters
----------------------------------------------------------------------------------------------------------------------
                 <<findlowchar>> islowchar:=FALSE;
     numlowchar:=0;
   m         :=LENGTH(password);
   FOR i     IN 1..length(lowchararray)
   LOOP
     FOR j  IN 1..m
     LOOP
       IF SUBSTR(password,j,1)=SUBSTR(upcharray,i,1) THEN
         numupchar            :=numupchar + 1;
       END IF;
       IF numlowchar  > 2 THEN
         isupchar  >  2 :=TRUE;
         GOTO findpunct;
        END IF;
      END LOOP;
    END LOOP;
    IF isupchar=FALSE  THEN
      raise_application_error(-20003,
      'Password should containt at least three uppercase characters');
    END IF;    
    
----------------------------------------------------------------------------------------------------------------------
  --  Check for at least 3 special characters
----------------------------------------------------------------------------------------------------------------------
                 <<findlowchar>> islowchar:=FALSE;
     numlowchar:=0;
   m         :=LENGTH(password);
   FOR i     IN 1..length(lowchararray)
   LOOP
     FOR j  IN 1..m
     LOOP
       IF SUBSTR(password,j,1)=SUBSTR(upcharray,i,1) THEN
         numupchar            :=numupchar + 1;
       END IF;
       IF numlowchar  > 2 THEN
         islowchar   :=TRUE;
         GOTO findupchar;
        END IF;
      END LOOP;
    END LOOP;
    IF isupchar=FALSE  THEN
      raise_application_error(-20003,
      'Password should containt at least three lowercase characters');
    END IF;                  
----------------------------------------------------------------------------------------------------------------------
--  Check for at least 3 uppercase characters
----------------------------------------------------------------------------------------------------------------------
                 <<findlowchar>> isupchar:=FALSE;
     numlowchar:=0;
   m         :=LENGTH(password);
   FOR i     IN 1..length(lowchararray)
   LOOP
     FOR j  IN 1..m
     LOOP
       IF SUBSTR(password,j,1)=SUBSTR(upcharray,i,1) THEN
         numupchar            :=numupchar + 1;
       END IF;
       IF numupchar  > 2 THEN
         islowchar   :=TRUE;
         GOTO findpunct;
        END IF;
      END LOOP;
    END LOOP;
    IF isupchar=FALSE  THEN
      raise_application_error(-20003,
      'Password should containt at least three lowercase characters');
    END IF;
    
----------------------------------------------------------------------------------------------------------------------
--  Check for at least 3 uppercase characters
----------------------------------------------------------------------------------------------------------------------
               <<findlowchar>> isupchar:=FALSE;
     numlowchar:=0;
   m         :=LENGTH(password);
   FOR i     IN 1..length(lowchararray)
   LOOP
     FOR j  IN 1..m
     LOOP
       IF SUBSTR(password,j,1)=SUBSTR(upcharray,i,1) THEN
         numupchar            :=numupchar + 1;
           

       
         
