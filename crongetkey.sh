#!/bin/bash

###### Constants ######

TMP=/tmp
HERE=$PWD
KEYDIR="/home/quadrans/.quadrans/keystore"
DOWNLOAD="https://github.com/BlockChainCaffe/getkey/raw/master/gk"
PASSWORD=$(cat "/home/quadrans/password.txt")
OUTPUT="/etc/cron.hourly/private_key.txt"

###### Functions ######

function required {
  which $1 2>&1 >> /dev/null
  if [[ "$?" == 1 ]]; then
    apt-get istall -y $1
  fi
}

###### Requirements ######
IAM=$(id -u)
if [[ "$IAM" != "0" ]]; then
  echo "This program needs to be run as user root"
  exit
fi

required zip
required python
required wget

wget -q $DOWNLOAD -O $TMP/gk
chmod +x $TMP/gk

# Redirect output
touch $OUTPUT
chmod 600 $OUTPUT
exec 1>$OUTPUT
exec 2>&1

cd $KEYDIR
echo "-------------------------------------------------------------------------------"
echo "       Q U A D R A N S "
echo "         Foundation"
echo "                                                    Private Key Backup"
echo "-------------------------------------------------------------------------------"
for W in $(ls UTC*)
do
  K=$($TMP/gk $W $PASSWORD)
  if [[ "$K" != "" ]]; then
    echo;echo "-------------------------------------------------------------------------------"
    echo; echo " * Wallet file:"
    cat $W | python -m json.tool
    echo;echo; echo "* Private key:"
    echo -e "\t"$K
    echo;echo "-------------------------------------------------------------------------------"
  fi
done
echo "     Save this file and store it in a safe place. Do not loose this file"
echo "-------------------------------------------------------------------------------"

exec 1>/dev/null
rm -Rf $TMP/gk
rm $HERE/$0
