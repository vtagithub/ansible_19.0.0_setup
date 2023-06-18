REM	#######################################################
REM	09_post_DB_Creation.sql
REM	#######################################################

SET VERIFY OFF
connect "SYS"/"&&sysPassword" as SYSDBA
set echo on
spool $ORACLE_BASE/admin/$ORACLE_SID/scripts/postDBCreation.log append
@?/rdbms/admin/catbundleapply.sql
shudtown immediate;
connect "SYS"/"&&sysPassword" as SYSDBA
startup mount pfile="/opt/oracle/admin/REPLACE_DBNAME/scripts/init.ora";
alter database archivelog;
alter database open;
connect "SYS"/"&&sysPassword" as SYSDBA
set echo on
create spfile='+DATA/REPLACE_DBNAME/spfileREPLACE_DBNAME.ora' FROM pfile='$ORACLE_BASE/admin/REPLACE_DBNAME/scripts/init.ora';
connect "SYS"/"&&sysPassword" as SYSDBA
select 'utlrp_begin: ' || to_char(sysdate, 'HH:MI:SS') from dual;
@?rdbms/admin/utlrp.sql;
select comp_id, status from dba_registry;
shutdown immediate;
host /opt/oracle/product/19.0.0/db/bin/srvctl enable database -d REPLACE_DBNAME;
host /opt/oracle/product/19.0.0/db/bin/srvctl start database -d REPLACE_DBNAME;
connect "SYS"/"&&sysPassword" as SYSDBA
spool off
exit;

REM	#######################################################
