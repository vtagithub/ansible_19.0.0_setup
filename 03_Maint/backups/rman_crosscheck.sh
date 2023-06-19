#!/bin/sh
##############################################################################################################
# database_Level1_backup.sh
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
