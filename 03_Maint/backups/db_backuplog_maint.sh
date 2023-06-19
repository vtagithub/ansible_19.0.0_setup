#!/bin/sh
##############################################################################################################
# db_backuplog_maint.sh
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
 BACKUPDIR="$HOME/log"
 BACKUPLOG="database_backup_history.log"
 OPSVIEWDIR="/var/tmp"
 DATE=`date +%Y%m%d`
 TODAY=`date +%d`
 
 #copy log to /var/tmp fro OPSview monitor
if [ -s $BACKUPDIR/$BACKUPLOG ]
then
        `cp -u $BACKUPDIR/$BACKUPLOG $OPSVIEWDIR/$BACKUPLOG`
        `chmod 777 $OPSVIEWDIR/$BACKUPLOG`        
fi

# if today is the first, rotate log
if [ $TODAY == 01 ]
then
          if [ ! -f $BACKUPDIR/$BACKUPLOG.$DATE ]
          then
                   `cp -u $BACKUPDIR/$BACKUPLOG $BACKUPDIR/$BACKUPLOG.$DATE`
                   `cp /dev/null $BACKUPDIR/$BACKUPLOG`
          fi
fi
##############################################################################################################
                   
