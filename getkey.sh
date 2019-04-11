#!/bin/bash

###### Constants ######

TMP=/tmp
DIR="/home/quadrans/.quadrans/keystore"
PROG="https://github.com/BlockChainCaffe/getkey/raw/master/gk"
PAS=$(cat "/home/quadrans/password.txt")

RESET='\e[0m'
BGNOCOLOR='\e[49m'
BGBLUE='\e[44m'
BGMAGENTA='\e[45m'
BGCYAN='\e[46m'
WHITE='\e[97m'
BOLD='\e[1m'

###### Functions ######

function required {
  which $1 2>&1 >> /dev/null
  if [[ "$?" == 1 ]]; then
    apt-get istall -y $1
  fi
}

function header {
  clear
  echo -e $WHITE$BOLD
  echo -e    $BGBLUE" Q U A D R A N S                                                               "$BGNOCOLOR
  echo -e $BGMAGENTA"   Foundation                                                                  "$BGNOCOLOR
  echo -e    $BGCYAN"                                                        Private key retriever  "$BGNOCOLOR
  echo -e $RESET
}

###### Requirements ######

IAM=$(id -u)
if [[ "$IAM" != "0" ]]; then
  echo "This program needs to be run as user root"
  exit
fi

header
echo; echo "Installing missing dependencies... "
required zip
required python
required wget


header
echo; echo "Downloading needed Software... "
wget -q $PROG -O $TMP/gk
chmod +x $TMP/gk

cd $DIR
header

for W in $(ls UTC*)
do
  K=$($TMP/gk $W $PAS)
  if [[ "$K" != "" ]]; then
    echo;echo "-------------------------------------------------------------------------------"
    echo; echo -e $WHITE$BOLD* "Wallet file:";echo -e $RESET
    cat $W | python -m json.tool
    echo;echo; echo -e $WHITE$BOLD"* Private key:";echo -e $RESET
    echo -e "\t"$K
    echo;echo "-------------------------------------------------------------------------------"
  fi
done

#rm -Rf $TMP/gk
