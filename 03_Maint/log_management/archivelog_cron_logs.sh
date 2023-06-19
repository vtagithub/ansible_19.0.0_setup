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
 cd $HOME/log
 find . -name '*.aud' -mtime +1 |xargs -n1 -I{} mv {} ./archive/{}.$DATE
 cd ./archive
 find . -name "*.$DATE" -exec gzip {} \;
