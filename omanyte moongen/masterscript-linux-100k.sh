#!/bin/bash

START=`date +%s`
INTERVAL=" 100 1500 50"

cd /home/schramm
ssh omastar 'cp /home/schramm/00-header-mod /etc/update-motd.d/00-header'
ssh omastar 'modprobe msr ; pqos -R'
ssh omastar '/home/schramm/unbind-linux-routing.sh'
ssh omastar '/home/schramm/build-linux-kernel-test2.sh 100001'
ssh omastar '/home/schramm/disable-turbo-offloading.sh'
sleep 10

./mg-bench.sh -f 1 -n L10-000001 -r $INTERVAL -c linux
./mg-bench.sh -f 10 -n L10-000010 -r $INTERVAL -c linux
./mg-bench.sh -f 100 -n L10-000100 -r $INTERVAL -c linux
./mg-bench.sh -f 1000 -n L10-001000 -r $INTERVAL -c linux
./mg-bench.sh -f 10000 -n L10-010000 -r $INTERVAL -c linux
./mg-bench.sh -f 100000 -n L10-100000 -r $INTERVAL -c linux

ssh omastar '/home/schramm/unbind-linux-routing.sh'
ssh omastar 'pqos -e llc:1=0x00001'
ssh omastar 'pqos -a llc:1=10'
ssh omastar '/home/schramm/build-linux-kernel-test2.sh 100001'

./mg-bench.sh -f 1 -n L11-000001 -r $INTERVAL -c linux
./mg-bench.sh -f 10 -n L11-000010 -r $INTERVAL -c linux
./mg-bench.sh -f 100 -n L11-000100 -r $INTERVAL -c linux
./mg-bench.sh -f 1000 -n L11-001000 -r $INTERVAL -c linux
./mg-bench.sh -f 10000 -n L11-010000 -r $INTERVAL -c linux
./mg-bench.sh -f 100000 -n L11-100000 -r $INTERVAL -c linux

ssh omastar '/home/schramm/unbind-linux-routing.sh'
ssh omastar 'pqos -e llc:1=0x0000f'
ssh omastar 'pqos -a llc:1=10'
ssh omastar '/home/schramm/build-linux-kernel-test2.sh 100001'

./mg-bench.sh -f 1 -n L12-000001 -r $INTERVAL -c linux
./mg-bench.sh -f 10 -n L12-000010 -r $INTERVAL -c linux
./mg-bench.sh -f 100 -n L12-000100 -r $INTERVAL -c linux
./mg-bench.sh -f 1000 -n L12-001000 -r $INTERVAL -c linux
./mg-bench.sh -f 10000 -n L12-010000 -r $INTERVAL -c linux
./mg-bench.sh -f 100000 -n L12-100000 -r $INTERVAL -c linux

ssh omastar '/home/schramm/unbind-linux-routing.sh'
ssh omastar 'pqos -e llc:1=0xffff0'
ssh omastar 'pqos -e llc:2=0x0000f'
ssh omastar 'pqos -a llc:1=10'
ssh omastar 'pqos -a llc:2=0-9,11-39'
ssh omastar '/home/schramm/build-linux-kernel-test2.sh 100001'

./mg-bench.sh -f 1 -n L13-000001 -r $INTERVAL -c linux
./mg-bench.sh -f 10 -n L13-000010 -r $INTERVAL -c linux
./mg-bench.sh -f 100 -n L13-000100 -r $INTERVAL -c linux
./mg-bench.sh -f 1000 -n L13-001000 -r $INTERVAL -c linux
./mg-bench.sh -f 10000 -n L13-010000 -r $INTERVAL -c linux
./mg-bench.sh -f 100000 -n L13-100000 -r $INTERVAL -c linux

ssh omastar '/home/schramm/unbind-linux-routing.sh'
ssh omastar 'pqos -R'
ssh omastar 'cp /home/schramm/00-header-org /etc/update-motd.d/00-header'

END=`date +%s`
DURATION=$(($END - $START))
HDURATION=$(($DURATION / 3600))
echo "Messung dauerte  $DURATION Sekunden oder $HDURATION Stunden"

exit 0

