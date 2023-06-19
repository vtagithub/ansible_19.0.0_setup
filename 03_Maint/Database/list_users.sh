REM	##############################################################################################################
REM	list_profiles.sql
REM	##############################################################################################################
. $HOME/.profile
unset SQLPATH
DATE=`date \+\%Y\%m\%d`
NodeName=`uname -n`

export DATE
export NodeName
export ORAENV_ASK=NO

cd $HOME/Reports
find $HOME/Reports -name '*.User_List2.lst' -mtime -exec rm {} \;
find $HOME/Reports -name '*Role_List.lst' -mtime +7 rm {} \;
find $HOME/Reports -name '*Profile.lst' -mtime +7 rm {} \;

cat /etc/oratab | grep -v "^#" | grep -v "^$" | grep -v "*" | grep -v "+ASM" | awk -F: '{print $1' | while read ORACLE_SID
do
      oraenv -s
      echo 'ORACLE_SID is ' $ORACLE_SID
      sqlplus "/ as sysdba" @$HOME/sql/list_users2.sql
      sqlplus "/ as sysdba" @$HOME/sql/list_roles.sql
      sqlplus "/ as sysdba" @$HOME/sql/list_profiles.sql
done

echo define NodeName=$NodeName > /tmp/reload_user_tbl.sql
cat *.User_List2.lst >> /tmp/reload_user_tbl.sql
cat *.Role_List.lst >> /tmp/reload_user_tbl.sql
cat *.Profile_List.lst >> /tmp/reload_user_tbl.sql

sqlplus <<EOF
altdba_exec/"Hur\$8InowHur\$8Iow"@ALTDBARP
set echo on
set define #
spool /tmp/reload_user_tbl.lst
alter session set nls_date_format='yyy-mm-dd-hh24:mi';
start /tmp/reload_user_tbl.sql
spool off
EOF
REM	##############################################################################################################

      
