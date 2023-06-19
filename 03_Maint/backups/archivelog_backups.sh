#!/bin/sh
##############################################################################################################
# Archivelog_backups.sh
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


export PATH=$ORACLE_HOME/bin:$PATH
export  RUNTIME=`date +%m%d%y-%H%M%S`'

cat $ORATAB | grep -v "^#"  | grep -v "^$"  | grep -v "*" | grep -v "+ASM"  | awk -F: '{print $1} | while read ORACLE_SID
do

. oraenv -s

rman target / log $HOME/log/"$ORACLE_SID"_archivelog_backup="$RUNTIME".log<<EOF
run
{
    allocate channel CH1 type sbt_tape PARMS=(TDPO_OPTFILE=/opt/tivoli/tsm/client/oracle/bin64/tdpo.opt/" MAXPIECESIZE 10G;
    backup archivelog all delete input;
    release channel CH1;
}

quit
EOF

RC=$>
echo  ""  >>  $HOME/log/"$ORACLE_SID"_archivelog_backup-"$RUNTIME".log
echo "Archivelog Backup Complete" >>  $HOME/log/"$ORACLE_SID"_archivelog_backup-"$RUNTIME".log
echo "Return Code:" $RC >>  $HOME/log/"$ORACLE_SID"_archivelog_backup-"$RUNTIME".log
echo  "------------End of File-------------------"  >>  $HOME/log/"$ORACLE_SID"_archivelog_backup-"$RUNTIME".log
done
exit  $RC
##############################################################################################################

 
        
