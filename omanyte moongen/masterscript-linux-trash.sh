#!/bin/bash

START=`date +%s`
INTERVAL=" 100 1000 50"

cd /home/schramm
ssh omastar 'cp /home/schramm/00-header-mod /etc/update-motd.d/00-header'
ssh omastar 'modprobe msr ; pqos -R'
ssh omastar '/usr/bin/killall stress-ng'
ssh omastar '/home/schramm/unbind-linux-routing.sh'
ssh omastar '/home/schramm/build-linux-kernel-test2.sh'
#ssh omastar '/usr/bin/screen -AmdS offload /home/schramm/disable-turbo-offloading.sh'
sleep 10
ssh omastar '/home/schramm/stress.sh 21600 linux'

./mg-bench.sh -f 1 -n L4-000001 -r $INTERVAL -c linux
./mg-bench.sh -f 1000 -n L4-001000 -r $INTERVAL -c linux
./mg-bench.sh -f 50000 -n L4-050000 -r $INTERVAL -c linux
./mg-bench.sh -f 100000 -n L4-100000 -r $INTERVAL -c linux
./mg-bench.sh -f 250000 -n L4-250000 -r $INTERVAL -c linux
./mg-bench.sh -f 500000 -n L4-500000 -r $INTERVAL -c linux

ssh omastar '/usr/bin/killall stress-ng'
ssh omastar '/home/schramm/unbind-linux-routing.sh'
ssh omastar 'pqos -e llc:1=0x00001'
ssh omastar 'pqos -e llc:2=0xffffe'
ssh omastar 'pqos -a llc:1=10'
ssh omastar 'pqos -a llc:2=0-9,11-39'
ssh omastar '/home/schramm/build-linux-kernel-test2.sh'
ssh omastar '/home/schramm/stress.sh 21600 linux'

./mg-bench.sh -f 1 -n L5-000001 -r $INTERVAL -c linux
./mg-bench.sh -f 1000 -n L5-001000 -r $INTERVAL -c linux
./mg-bench.sh -f 50000 -n L5-050000 -r $INTERVAL -c linux
./mg-bench.sh -f 100000 -n L5-100000 -r $INTERVAL -c linux
./mg-bench.sh -f 250000 -n L5-250000 -r $INTERVAL -c linux
./mg-bench.sh -f 500000 -n L5-500000 -r $INTERVAL -c linux

ssh omastar '/usr/bin/killall stress-ng'
ssh omastar '/home/schramm/unbind-linux-routing.sh'
ssh omastar 'pqos -e llc:1=0x0000f'
ssh omastar 'pqos -e llc:2=0xffff'
ssh omastar 'pqos -a llc:1=10'
ssh omastar 'pqos -a llc:2=0-9,11-39'
ssh omastar '/home/schramm/build-linux-kernel-test2.sh'
ssh omastar '/home/schramm/stress.sh 21600 linux'

./mg-bench.sh -f 1 -n L6-000001 -r $INTERVAL -c linux
./mg-bench.sh -f 1000 -n L6-001000 -r $INTERVAL -c linux
./mg-bench.sh -f 50000 -n L6-050000 -r $INTERVAL -c linux
./mg-bench.sh -f 100000 -n L6-100000 -r $INTERVAL -c linux
./mg-bench.sh -f 250000 -n L6-250000 -r $INTERVAL -c linux
./mg-bench.sh -f 500000 -n L6-500000 -r $INTERVAL -c linux

ssh omastar '/usr/bin/killall stress-ng'
ssh omastar '/home/schramm/unbind-linux-routing.sh'
ssh omastar 'pqos -R'
ssh omastar 'cp /home/schramm/00-header-org /etc/update-motd.d/00-header'

END=`date +%s`
DURATION=$(($END - $START))
HDURATION=$(($DURATION / 3600))
echo "Messung dauerte  $DURATION Sekunden oder $HDURATION Stunden"

exit 0

