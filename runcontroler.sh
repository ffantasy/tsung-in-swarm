#!/bin/bash

if [ $# != 1 ]; then
echo "usage error."
exit 1;
fi 

TSUNG_CONFIG_FILE=/root/config.xml
CLIENTS_STORE_FILE=clients.txt
MONITORS_STORE_FILE=monitors.txt
/usr/sbin/sshd

cp /tmp/config.xml $TSUNG_CONFIG_FILE
rm -f $CLIENTS_STORE_FILE && touch $CLIENTS_STORE_FILE
rm -f $MONITORS_STORE_FILE && touch $MONITORS_STORE_FILE

echo -e "\e[33mwaiting client node join...\e[0m"
lineCount=0
while [ $lineCount -lt $1 ]; do
    sleep 1s
    lineCountStr=$(wc -l clients.txt)
    lineCount=${lineCountStr% *} #substr
    echo -ne "\r$lineCount client(s) has join."
done
echo -e "\n\e[33mrun tsung...\e[0m"
sed -i "/<clients>/r $CLIENTS_STORE_FILE" $TSUNG_CONFIG_FILE
sed -i "/<monitoring>/r $MONITORS_STORE_FILE" $TSUNG_CONFIG_FILE
tsung -f $TSUNG_CONFIG_FILE -l log -k start
