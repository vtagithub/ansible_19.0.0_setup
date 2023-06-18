REM	#######################################################
REM	06_CreateDBCatalog.sql
REM	#######################################################

SET  VERIFY OFF
connect "SYS"/"$$SYSPassword" as SYSDBA
set echo on
spool $ORACLE_BASE/admin/$ORACLE_SID/scripts/CreateDBCatalog.log append
@?/rdms/admin/catalog.sql
@?/rdbms/admin/catproc.sql
@?/rdbms/admin/catoctk.sql
connect "SYSTEM"/"&&systemPAssword"
set echo on
spool $ORACLE_BASE/admin/$ORACLE_SID/scripts/sqlPlusHel.log append
@?/sqlplus/admin/help/hlpbld.sql helpus.sql;
spool off
spool off
connect "SYS"/"&&sysPassword" as SYSDBA
set echo on
spool $ORACLE_BASE/admin/$ORACLE_SID/scripts/postDBCreation.log append
grant sysdg to sysdg;
grant sysbackup to sysbackup;
grant syskm to syskm;
REM	#######################################################
