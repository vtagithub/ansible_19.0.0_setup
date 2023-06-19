REM	##############################################################################################################
REM	list_profiles.sql
REM	##############################################################################################################
column Database format a10
column grantee format a30
column granted_role format a30
set linesize 150
set pagesisze 0
set feedback off
alter session set nls_date_format = 'yyy-mm-dd-hh24:mi';|
spool $ORACLE_SID.Role_List.lst
select 'delete from altdba.role_privs where database_name = ''' ||
value || ''' and node_name = ''#NodeName'';'
  from v$parameter
where name = 'db_name'
/
select 'insert into altdba.role_privs values(''#NodeName'',''' ||
  substr(p.value,1,30)      || ''',''' ||
  r.grantee                 || ''',''' ||
  r.granted_role            || ''',''' ||
  r.admin_option            || ''',''' ||
  r.default_role            || ''',''' ||
  sysdate || ''');'
from dba_role_privs r
, v$parameter p
where p.name = 'db_name'
  and r.grantee not in ('SYS','SYSTEM')
order by r.granted_role, r.grantee
/
spool off
exit
REM	##############################################################################################################
