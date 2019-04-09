#!/bin/bash

BSD=$(pwd)
DIR="/home/quadrans/.quadrans/keystore"
PAS=$(cat "/home/quadrans/password.txt")

RESET='\e[0m'
BGNOCOLOR='\e[49m'
BGBLUE='\e[44m'
BGMAGENTA='\e[45m'
BGCYAN='\e[46m'
WHITE='\e[97m'
BOLD='\e[1m'

echo -e $WHITE$BOLD
echo -e    $BGBLUE" Q U A D R A N S                                                               "$BGNOCOLOR
echo -e $BGMAGENTA"   Foundation                                                                  "$BGNOCOLOR
echo -e    $BGCYAN"                                                        Private key retriever  "$BGNOCOLOR
echo -e $RESET

cd $DIR
for W in $(ls UTC*)
do
  K=$($BSD/gk $W $PAS)
  if [[ "$K" != "" ]]; then
    echo;echo "----------------------------------------------------"
    echo; echo -e $WHITE$BOLD* "Wallet file:";echo -e $RESET
    cat $W | python -m json.tool
    echo;echo; echo -e $WHITE$BOLD"* Private key:";echo -e $RESET
    echo $K
    echo;echo "----------------------------------------------------"
  fi
done
