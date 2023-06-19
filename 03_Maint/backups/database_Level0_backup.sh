#!/bin/sh
##############################################################################################################
# database_Level0_backup.sh
##############################################################################################################
if [ -f $HOME/.profile ]
then
        . $HOME/.profile
elif [ -f $HOME/.bash_profile ]
then    
        . $HOME/.bash_profile
 else
        ehco "A profile does not exit"
 fi
 
 if   [ -f /etc/oratab  ]
 then
      export  ORATAB='/etc/oratab'
 elif [ -f /var/opt/oracle/oratab ]
 then
      export  ORATAB='/var/opt/oracle/oratab'
 else
      echo "An oratab file does not exists"
fi

cd $HOME/bin
export PATH=$ORACLE_HOME/bin:$PATH
export RUNTIME=`date +%m%d%y-%H%M%S`
export RMANPASS=`openssl enc -in rman.pass -d -aes256 -k symmetrickey'
export DATE=`date \+\%Y\%m\%d\-\%H\%M`
export BDATE=`date +%m.%d.%y`
export BACKUPHIST="$HOME/log/database_bakcup_history.log"

cat $ORATAB | grep -v "^#  | grep -v "^$" | grep -v "*" | grep-v "+ASM" | awk -F: '{print $1} | whle read ORACLE_SID
do

. oraenv -s

rman target / log $HOME/log/"$ORACLE_SID"_LEVEL0Pbackup-"$RUNTIME".log<<EOF
         run
         {
