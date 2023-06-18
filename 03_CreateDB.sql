REM	#######################################################
REM	03_CreateDB.sql
REM	#######################################################

set verify off
ACCEPT sysPassword CHAR PROMPT 'Enter new password for SYS: ' HIDE
ACCEPT systemPassword CHAR PROMPT 'Enter new password for SYSTEM: ' HIDE

host /opt/oracel/prodcut/19.0.0/db/bin/srvctl add database -d $ORACLE_SID -0 /opt/oracle/prodcut/19.0.0/db -p +DATA/$ORACLE_SID/spfile$ORACLE_SID.ora -n $ORACLE_SID

host /opt/oracel/prodcut/19.0.0/db/bin/srvctl disable database -d $ORACLE_SID

host /opt/oracel/prodcut/19.0.0/db/bin/orapwd file=host /opt/oracel/prodcut/19.0.0/db/dbs/orapw$ORACLE_SID force=y format=12

host /opt/oracel/prodcut/19.0.0/crs/bin/setasmgidwrap o=/opt/oracel/prodcut/19.0.0/db/bin/oracle

@$ORACLE_BASE/admin/$ORACLE_SID/scripts/04_CreateDBInstance.sql
@$ORACLE_BASE/admin/$ORACLE_SID/scripts/05_CreateDBFiles.sql
@$ORACLE_BASE/admin/$ORACLE_SID/scripts/06_CreateDBCatalog.sql

host echo "SPFILE='+DATA/$ORACLE_SID/spfile$ORACLE_SID.ora'" > /opt/oracle/prodcut/19.0.0/dbs/dbs/init$ORACLE_SID.ora
@$ORACLE_BASE/admin/$ORACLE_SID/scripts/08_lockAccount.sql
@$ORACLE_BASE/admin/$ORACLE_SID/scripts/09_postDBCreation.sql
REM	#######################################################
