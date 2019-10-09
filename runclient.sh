#!/bin/bash

if [ $# != 1 ]; then
echo "usage error."
exit 1;
fi

IP=$(hostname -i | sed "s/ .*//")
HOST=$(echo $IP | sed "s/\./-/g; s/^/worker-/")
/usr/sbin/sshd
ssh $1 "echo '<monitor host=\"${HOST}\" \/>' >> /root/monitors.txt && echo '<client host=\"${HOST}\" \/>' >> /root/clients.txt && echo ${IP}' '${HOST} >> /etc/hosts"
sleep 3650000d
