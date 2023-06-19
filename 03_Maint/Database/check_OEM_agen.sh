#!/bin/sh
##############################################################################################################
# check_OEM_agen.sh
##############################################################################################################
if [ -e $HOME/.profile ]
then
        . $HOME/.profile
elif [ -e $HOME/.bash_profile ]
then    
        . $HOME/.bash_profile
 else
        echo "A profile does not exit"
 fi
 export ARGS=`echo $@ 
