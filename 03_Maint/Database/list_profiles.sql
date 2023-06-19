REM	##############################################################################################################
REM	list_profiles.sql
REM	##############################################################################################################
column Database format a10
column username format a21 heading "User Name"
column account_status format a20 heading "Account Status"
column lock_date heading "Lock Date"
column expiry_date heading "Expiry|Date"
column Objects_Owned heading "Objects|Owned"
set linesize 250
set pagesize 0
set feedback off
alter session set nsl_date_format='yyy-mm-dd-hh24:mi';
spool $ORACLE_SID.Prfoile_List.lst
select 'delete from altdba.database_profile where database_name = ''' ||
value || ''' and node_name = ''#NodeName'';'
  from v$parameter
 where name = 'db_name'
 /
 select 'insert into altdba.database_profile values(''' ||
   p1.profile                     || ''',''' ||
   substr(d.value,1,30)           || ''',''#NodeName'','' ||
   sysdate || ''',''' ||
   p1.limit || ''',''' ||
   p2.limit || ''',''' ||
   p3.limit || ''',''' ||
   p4.limit || ''',''' ||
   p5.limit || ''',''' ||
   p6.limit || ''',''' ||
   p7.limit || ''',''' ||
   p8.limit || ''',''' ||
   p9.limit || ''');'
from dba_profile p1
   , dba_profile p1
   , dba_profile p2
   , dba_profile p3
   , dba_profile p4
   , dba_profile p5
   , dba_profile p6
   , dba_profile p7
   , dba_profile p8
   , dba_profile p9
   , v$parameter d
where d.name = 'db_name'
  and p1.profile = p2.profile
  and p1.profile = p3.profile
  and p1.profile = p4.profile
  and p1.profile = p5.profile
  and p1.profile = p6.profile
  and p1.profile = p7.profile
  and p1.profile = p8.profile
  and p1.profile = p9.profile  
  and p1.resource_name = 'CONNECT_TIME'
  and p2.resource_name = 'FAILED _LOGIN_ATTEMPTS'
  and p3.resource_name = 'IDLE_TIME'
  and p4.resource_name = 'PASSWORD_GRACE_TIME'
  and p5.resource_name = 'PASSWORD_LIFE_TIME'
  and p6.resource_name = 'PASSWORD_LOCK_TIME'
  and p7.resource_name = 'PASSWORD_REUSE_MAX'
  and p8.resource_name = 'PASSWORD_REUSE_TIME'
  and p9.resource_name = 'PASSWORD_VERIFY_FUNCTION'
order by p1.profile
/
spool off
exit
REM ##############################################################################################################

