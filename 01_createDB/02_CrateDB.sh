#!/bin/sh
#######################################################
# 02_CrateDB.sh
#######################################################

OLD_UMASK-`umask`
umask 0027
mkdir -p $ORACLE_BASE/amdin/$ORACLE_SID/adump
mkdir -p $ORACLE_BASE/amdin/$ORACLE_SID/dpdump
mkdir -p $ORACLE_BASE/amdin/$ORACLE_SID/pfile
mkdir -p $ORACLE_BASE/amdin/cfgtoollogs/$ORACLE_SID
umask ${OLD_UMASK}

PERL5LIB=$ORACLE_HOME/rdbms/admin:$PERL5LIB
export PERL5LIB

ORACLE_SID=$ORACLE_SID
export ORACLE_SID

PATH=$ORACLE_HOME/bin:$ORACLE_HOME/perl/bin:$PATH
export PATH

/opt/oracle/product/19.0.0/db/bin/sqlplus /nolog @$ORACLE_BASE/admin$ORACLE_SID/scripts/03_CreateDB.sql
#######################################################
