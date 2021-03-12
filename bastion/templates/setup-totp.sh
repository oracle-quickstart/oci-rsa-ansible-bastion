#!/bin/sh
oathdir="${HOME}/.oath"
oathfile="${oathdir}/opc.oath"
 
# Skip unless running over SSH
test -z $SSH_TTY && exit

sudo grep 'INITIAL SETUP' $oathfile > /dev/null 2>&1
 
if [[ $? -eq 0 ]]
then
    hex=`openssl rand -hex 20`
 
    echo "HOTP/T30/6 `whoami` - $hex" > ${oathfile}.$$
 
    sudo cp ${oathfile}.$$ ${oathfile}
    sudo chown root ${oathfile}
    sudo chmod 600 ${oathfile}
    /bin/gen-oath-safe opc totp $hex
 
    echo "*** USE THIS CODE OR LOSE ACCESS TO THIS HOST ***"
    rm ${oathfile}.$$
 fi