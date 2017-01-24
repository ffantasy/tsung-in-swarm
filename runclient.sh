#!/bin/bash

if [ $# != 1 ]; then
echo "usage error."
exit 1;
fi

service ssh start
ssh $1 "echo '<monitor host=\"$(hostname)\" />' >> /root/monitors.txt && echo '<client host=\"$(hostname)\" />' >> /root/clients.txt"
sleep infinity
