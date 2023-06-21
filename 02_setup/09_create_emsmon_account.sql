REM=======================================================
REM	09_create_emsmon_account.sql
REM=======================================================

--- 

 CREATE USER "DB_MY_EMSMON" IDENTIFIED BY "password12345"
        DEFAULT TABLESPACE "NON_APP_DATA"
        TEMPORARY TABLESPACE "TEMP"
        PROFILE "MONITORIN_PROFILE"
 ;
 
 grant VTA_CONNECT to DB_MY_EMSMON;
CREATE PUBLIC SYNONYM DBA_TABLESPACE_USAGE_METRICS FOR DBA_TABLESPACE_USAGE_METRICS;

REM=======================================================
