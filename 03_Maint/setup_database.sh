#!/bin/sh
##############################################################################################################
# setup_database.sh
##############################################################################################################
oracle_sid=`echo $ORACLE_SID | tr '[:upper:]' '[:lower:]
mkdir -p $ORACLE_BASE/admin$ORACLE_SID

cd $ORACLE_BASE/admin/$ORACLE_SID

ln -s /opt/oracle/diag/rdbms/$oracle_sid/$ORACLE_SID/trace bdump
ln -s /opt/oracle/diag/rdbms/$oracle_sid/$ORACLE_SID/cdump cdump
ln -s /opt/oracle/diag/rdbms/$oracle_sid/$ORACLE_SID/adump adump

mkdir -p /opt/oracle/diag/rdbms/$oracle_sid/$ORACLE_SID/trace/archive
mkdir -p /opt/oracle/diag/rdbms/$oracle_sid/$ORACLE_SID/cdump/archive
mkdir -p /opt/oracle/diag/rdbms/$oracle_sid/$ORACLE_SID/adump/archive

chmod u+x $HOME/bin
mkdir -p $HOME/log/archive
mkdir -p $HOME/bin/archive
mkdir $HOME/Reports
mkdir $HOME/sql

sed -i '$i \syntax off' $HOME/.vimrc

cp $HOME/19c_setup/03_maint/database/list_profiles.sql $HOME/sql
cp $HOME/19c_setup/03_maint/database/list_roles.sql $HOME/sql
cp $HOME/19c_setup/03_maint/database/list_user2.sql $HOME/sql
cp $HOME/19c_setup/03_maint/database/list_users.sh $HOME/bin
cp $HOME/19c_setup/03_maint/database/check_OEM_agent.sh $HOME/bin

mv -i $HOME/19c_setup/03_maint/log_management/archive_alert_log.sh $HOME/bin
mv -i $HOME/19c_setup/03_maint/log_management/archive_audit_log.sh $HOME/bin
mv -i $HOME/19c_setup/03_maint/log_management/archive_cron_log.sh $HOME/bin
mv -i $HOME/19c_setup/03_maint/log_management/archive_listener_log.sh $HOME/bin
mv -i $HOME/19c_setup/03_maint/log_management/archive_trace_files.sh $HOME/bin
mv -i $HOME/19c_setup/03_maint/log_management/cleanup_archives.sh $HOME/bin

mv -i $HOME/19c_setup/03_maint/backups/archivelog_backup.sh $HOME/bin
mv -i $HOME/19c_setup/03_maint/backups/database_LEVEL0_backup.sh $HOME/bin
mv -i $HOME/19c_setup/03_maint/backups/database_LEVEL1_backup.sh $HOME/bin
mv -i $HOME/19c_setup/03_maint/backups/db_backuplog_maint.sh $HOME/bin
mv -i $HOME/19c_setup/03_maint/backups/rman_crosscheck.sh $HOME/bin

chmod u+x $HOME/bin/*.sh

#Symbolic Link for tnsname.ora
ln -s $TNS_ADMIN/tnsnames.ora $ORACLE_HOME/network/admin/tnsnames.ora

echo "ALTDBA =" >> $TNS_ADMIN/tnsnames.ora

echo " (DESCRIPTION =" >> $TNS_ADMIN/tnsnames.ora
echo "    (ADDRESS_LIST =" >> $TNS_ADMIN/tnsnames.ora
echo "       (ADDRESS = (PROTOCOL = TCP)(HOST = 192.168.137.129)(PORT = 1521))" >> $TNS_ADMIN/tnsnames.ora
echo "       (ADDRESS = (PROTOCOL = TCP)(HOST = 192.168.137.128)(PORT = 1521))" >> $TNS_ADMIN/tnsnames.ora
echo "          )" >> $TNS_ADMIN/tnsnames.ora
echo "     (CONNECT_DATA =" >> $TNS_ADMIN/tnsnames.ora
echo "       (SID = TESTDB)" >> $TNS_ADMIN/tnsnames.ora
echo "       (SERVER = DEDICATED)" >> $TNS_ADMIN/tnsnames.ora
echo "     )" >> $TNS_ADMIN/tnsnames.ora
echo "   )" >> $TNS_ADMIN/tnsnames.ora

##############################################################################################################





