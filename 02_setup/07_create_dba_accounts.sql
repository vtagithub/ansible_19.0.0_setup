REM#######################################################
REM	07_create_dba_accounts.sql
REM#######################################################

create user JOHN_ADMIN identified by "password123" profile vta_default password expire default tablespace NON_APP_DATA;
grant DBA to JOHN_ADMIN;

create user DOE_ADMIN identified by "password123" profile vta_default password expire default tablespace NON_APP_DATA;
grant DBA to JOHN_ADMIN;

REM#######################################################
