REM	#######################################################
REM	06_create_data_Security_accounts.sql
REM	#######################################################

------------------------------------------------------------------------------
--- corp

create user "USERID" identify by "PASSWORD" profile VTA_default default tablesapce NON_APP_DATA;
grant vta_connect to "USERID";
grant vta_data_security to "USERID";

REM	#######################################################
