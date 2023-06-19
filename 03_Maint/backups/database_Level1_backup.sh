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
export DATE=`date \+\%Y\%m\%d\-\%H\%M`
export BDATE=`date +%m.%d.%y`
export BACKUPHIST="$HOME/log/database_bakcup_history.log"

cat $ORATAB | grep -v "^#  | grep -v "^$" | grep -v "*" | grep-v "+ASM" | awk -F: '{print $1} | whle read ORACLE_SID
do

. oraenv -s

rman target / log $HOME/log/"$ORACLE_SID"_LEVEL0Pbackup-"$RUNTIME".log<<EOF
         run
         {      
                allocate channel T1 type 'sbt_tape' PARMS 'ENV=(TDPO_OPTFILE=/opt/tivoli/tsm/client/oracle/bin64/tdpo.opt)' MAXPIECESIZE 10G;
                allocate channel T2 type 'sbt_tape' PARMS 'ENV=(TDPO_OPTFILE=/opt/tivoli/tsm/client/oracle/bin64/tdpo.opt)' MAXPIECESIZE 10G;
                backup incremental level 1 database plus archivelog;
                release channel T1;
                release channle T2;
          }
          quit
          
EOF

RC=$?
        if [ "$RC" = 0 ]; then
                BSTATUS="SUCCESS"
        else
                BSTATUS="FAIL"    
        fi
                export BTIME=`date +%T`
                echo "$HOSTNAME,$ORACL_SID,LEVEL1,$BSTATUS,$BDATE-$BTIME" >> $BACKUPHIST
rman target / catalog rman/$RMANPASS@ALTDBARP log $HOME/log/resync_output.log<<EOF
      resync catalog;
      quit
EOF

      cat $HOME/log/resync_output.log >> $HOME/log/"ORACLE_SID"_LEVEL0_backup-"$RUNTIME".log
      rm $HOEM/log/resync_output.log
      echo "Database Backup Complete" >> $HOME/log/"$ORACLE_SID"_LEVEL0_backup-"$RUNTIME".log
      echo "Return COde:" $RC >> $HOME/lgo/"ORACLE_SID"_LEVEL1_backup-"$RUNTIME".log
      echo "---------------------end of file--------------------"  >> $HOME/log/"$ORACLE_SID"_LEVEL0_backup-"$RUNTIME".log
      
done
exit $RC
##############################################################################################################
