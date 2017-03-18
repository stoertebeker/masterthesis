#!/bin/bash

if [ -z "$1" ]
then
	RULES=600000
else
	RULES=$1
fi
echo $RULES

/root/dpdk/tools/dpdk-devbind.py -b ixgbe 0000:81:00.0 0000:81:00.1
ifconfig ens5f0 10.0.0.1
ifconfig ens5f1 10.0.1.1
ifconfig ens5f1 netmask 255.255.255.0
/home/schramm/linux-routing-table-gen2.sh $RULES
