REM	#######################################################
REM	04_CreateDBInstance.sql
REM	#######################################################

SET VERIFY OFF
connect "SYS/"&&syspassword" as SYSDBA
set echo on
spool $ORACLE_BASE/admin/$ORACLE_SID/scripts/CreateDB.log append
startup nomount pfile="ORACLE_BASE/admin/$ORACLE_SID/scripts/init.ora";
CREATE DATABASE REPLACE_DBNAME
MAXINSTANCE 8
MAXLOGHISTORY 1
MAXLOGFILES 16
MAXLOGMEMBERS 3
MAXDATAFILES 100
DATAFILE SIZE 1000M
EXTENT MANAGEMENT LOCAL
SYSAUX DATAFILE SIZe 1000M
SMALLFILE DEFAULT TEMPORARY TABLESPACE TEMP TEMPFILE SIZE 1000M
SMALLFILE UNDO TABLESPACE "UNDOTBS1" DATAFILE SIZE 1000M
CHARACTER SET WE8MSWIN1252
NATIONAL CHARACTER SET AL16UTF16
LOGIFLE GROUP 1 SIZE 100M,
GROUP 2 SIZE 100M, 
GROUP 3 SIZE 100M,
GROUP 4 SIZE 100M,
GROUP 5 SIZE 100M
USER SYS IDENTIFIED BY "&&sysPassword" USER SYSTEM IDENTIFIED BY "&&systemPassword";
set linesize 2048;
set head off;
column ctl_files NEW_VALUE ctl_files;
select concat('control_files=''', concat(replace(value, ', ', ''',''')) ctl_files from v$parameter where name ='control_files';
host echo "&ctl_files" >> $ORACLE_BASE/admin/$ORACLE_SID/scripts/init.ora
spool off
REM	#######################################################
