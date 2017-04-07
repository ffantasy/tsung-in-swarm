#!/bin/bash

if [ $# != 1 ]; then
echo "usage error."
exit 1;
fi

IP=$(hostname -i | sed "s/ .*//")
HOST=$(echo $IP | sed "s/\./-/g; s/^/worker-/")
service ssh start
ssh $1 "echo '<monitor host=\"${HOST}\" />' >> /root/monitors.txt && echo '<client host=\"${HOST}\" />' >> /root/clients.txt && echo ${IP}' '${HOST} >> /etc/hosts"
sleep infinity
