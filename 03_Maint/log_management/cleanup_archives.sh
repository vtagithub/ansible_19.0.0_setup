#!/bin/sh
##############################################################################################################
# cleanup_archives.sh
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
export DATE=`date +%Y%m%d-%H%M`
cat $ORATAB | grep -v "^#  | grep -v "^$" | grep -v "*" | grep-v "+ASM" | awk -F: '{print $1} | whle read ORACLE_SID
do
    cd $ORACLE_BASE/admin/$ORACLE_SID/adump/archive
    
