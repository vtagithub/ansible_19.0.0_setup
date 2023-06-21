#!/bin/sh
#######################################################
# 01_prep.sh
#######################################################
echo "Please type new ORACLE_SID:"
read ORACLE_SID
export	ORACLE_SID

echo "Please type new DB_DOMAIN:"
ead DB_DOMAIN
export DB_DOMAIN

ORAENV_ASK=NO
export ORAENV_ASK

HOST_NAME=`uname -n`
export HOST_NAME

oracle_sid=`echo $ORACLE_SID | tr 'A-Z' 'a-z'`
export oracle_sid

mkdir -p /opt/oracle/diag/rdbms/$oracle_sid/$ORACLE_SID/adump/archive

if [ $OS=SunOS ]
then
	cp -rp /var/opt/oracle/oratab ./oratab
	echo $ORACLE_SID:/opt/oracle/product/19.0.0/db:N >> /var/opt/oracle/oratab

else
	cp -rp /etc/oratab ./oratab
	echo $ORACLE_SID:/opt/oracle/product/19.0./db:N >> /etc/oratab
	
fi

. oraenv -s

perl -pi -e "s/REPLACE_DBNAME/$ORACLE_SID/g" init.ora
perl -pi -e "s/REPLACE_DBNAME/$ORACLE_SID/g" init.ora
perl -pi -e "s/REPLACE_DB_DOMAIN/$DB_DOMAIN/g" init.ora 

perl -pi -e "s/REPLACE_DBNAME/$ORACLE_SID/g" 04_CreateDBInstance.sql
perl -pi -e "s/REPLACE_DBNAME/$ORACLE_SID/g" 09_postDBCreation.sql
perl -pi -e "s/REPLACE_HOSTNAME/$HOST_NAME/g" 09_postDBCreation.sql


mkdir -p $ORACLE_BASE/admin/$ORACLE_SID/scripts
cp ./* $ORACLE_BASE/admin/$ORACLE_SID/scripts

#########################################################################
