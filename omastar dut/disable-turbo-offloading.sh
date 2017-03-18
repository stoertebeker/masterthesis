#!/bin/bash

#disable Turboboost, 1 means disable
echo "1" > /sys/devices/system/cpu/intel_pstate/no_turbo

#better way to disable (poof with command "i7z")
modprobe msr
wrmsr -a 0x1a0 0x4000850089
#enable with: wrmsr -a 0x1a0 0x850089

# Turn off uncore frequency scaling and select max frequency
wrmsr -a 0x620 0x3f3f

# Set cpu frequency govenor to performance for dedicated cores
/home/schramm/gov.sh f

#stop OVS-daemon
/etc/init.d/openvswitch-switch stop

#disable NIC offloading
ethtool -A ens5f0 autoneg off rx off tx off
ethtool -A ens5f1 autoneg off rx off tx off

ethtool -K ens5f0 rx off tx off tso off gso off gro off lro off
ethtool -K ens5f1 rx off tx off tso off gso off gro off lro off

