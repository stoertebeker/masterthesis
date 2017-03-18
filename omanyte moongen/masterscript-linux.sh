#!/bin/bash

START=`date +%s`
INTERVAL=" 100 1000 50"

cd /home/schramm
ssh omastar 'cp /home/schramm/00-header-mod /etc/update-motd.d/00-header'
ssh omastar 'modprobe msr ; pqos -R'
ssh omastar '/home/schramm/unbind-linux-routing.sh'
ssh omastar '/home/schramm/build-linux-kernel-test2.sh'
ssh omastar '/home/schramm/disable-turbo-offloading.sh'
sleep 10

./mg-bench.sh -f 1 -n L1-000001 -r $INTERVAL -c linux
./mg-bench.sh -f 1000 -n L1-001000 -r $INTERVAL -c linux
./mg-bench.sh -f 50000 -n L1-050000 -r $INTERVAL -c linux
./mg-bench.sh -f 100000 -n L1-100000 -r $INTERVAL -c linux
./mg-bench.sh -f 250000 -n L1-250000 -r $INTERVAL -c linux
./mg-bench.sh -f 500000 -n L1-500000 -r $INTERVAL -c linux

ssh omastar '/home/schramm/unbind-linux-routing.sh'
ssh omastar 'pqos -e llc:1=0x00001'
ssh omastar 'pqos -a llc:1=10'
ssh omastar '/home/schramm/build-linux-kernel-test2.sh'

./mg-bench.sh -f 1 -n L2-000001 -r $INTERVAL -c linux
./mg-bench.sh -f 1000 -n L2-001000 -r $INTERVAL -c linux
./mg-bench.sh -f 50000 -n L2-050000 -r $INTERVAL -c linux
./mg-bench.sh -f 100000 -n L2-100000 -r $INTERVAL -c linux
./mg-bench.sh -f 250000 -n L2-250000 -r $INTERVAL -c linux
./mg-bench.sh -f 500000 -n L2-500000 -r $INTERVAL -c linux

ssh omastar '/home/schramm/unbind-linux-routing.sh'
ssh omastar 'pqos -e llc:1=0x0000f'
ssh omastar 'pqos -a llc:1=10'
ssh omastar '/home/schramm/build-linux-kernel-test2.sh'

./mg-bench.sh -f 1 -n L3-000001 -r $INTERVAL -c linux
./mg-bench.sh -f 1000 -n L3-001000 -r $INTERVAL -c linux
./mg-bench.sh -f 50000 -n L3-050000 -r $INTERVAL -c linux
./mg-bench.sh -f 100000 -n L3-100000 -r $INTERVAL -c linux
./mg-bench.sh -f 250000 -n L3-250000 -r $INTERVAL -c linux
./mg-bench.sh -f 500000 -n L3-500000 -r $INTERVAL -c linux

ssh omastar '/home/schramm/unbind-linux-routing.sh'
ssh omastar 'pqos -R'
ssh omastar 'cp /home/schramm/00-header-org /etc/update-motd.d/00-header'

END=`date +%s`
DURATION=$(($END - $START))
HDURATION=$(($DURATION / 3600))
echo "Messung dauerte  $DURATION Sekunden oder $HDURATION Stunden"

exit 0

