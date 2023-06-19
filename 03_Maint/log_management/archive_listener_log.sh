#!/bin/sh
##############################################################################################################
# archive_alert_log.sh
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
 export DATE=`date +%Y%m%d-%H%M`
 cd $ORACLE_HOME/network/log
 DATE=`date +%Y%m%d-%H%M`
 cp listener.log listener.log.$DATE
 cp /dev/null listener.log
 gzip listener.log.$DATE
 mv -i listener.log.$DATE.gz ./archive
 
 cp listener2.log listener2.log.$DATE
 cp /dev/null listener2.log
 gzip listener2.log.$DATE
 mv -i listener2.log.$DATE.gz ./archive
##############################################################################################################
