REM	=======================================================
REM	08_create_security_Scan_Accounts.sql
REM	=======================================================

--- Account for performing Database scans

 CREATE USER "SVC_VTASCAN" IDENTIFIED BU "password12345"
        DEFAULT TABLESPACE "NON_APP_DATA"
        TEMPORARY TABLESPACE "TEMP"
        PROFILE "SECURITY_SCAN_PROFILE"
 ;
 
 grant DBA to SVC_VTASCAN;
 REM	=======================================================
 
