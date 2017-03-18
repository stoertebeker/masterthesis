#!/bin/bash

START=`date +%s`
INTERVAL=" 300 750 50"

cd /home/schramm
ssh omastar 'cp /home/schramm/00-header-mod /etc/update-motd.d/00-header'
ssh omastar 'modprobe msr ; pqos -R'
ssh omastar '/home/schramm/unbind-linux-routing.sh'
ssh omastar '/home/schramm/build-linux-kernel-test2.sh 100000'
ssh omastar '/home/schramm/disable-turbo-offloading.sh'
sleep 10

ssh omastar 'pqos -R'
ssh omastar 'pqos -e llc:1=0x00001'
ssh omastar 'pqos -a llc:1=10'

./mg-bench.sh -f 1 -n L00001-1 -r $INTERVAL -c linux
./mg-bench.sh -f 100 -n L00001-100 -r $INTERVAL -c linux
./mg-bench.sh -f 10000 -n L00001-10000 -r $INTERVAL -c linux

ssh omastar '/home/schramm/unbind-linux-routing.sh'
ssh omastar 'pqos -R'
ssh omastar 'pqos -e llc:1=0x00003'
ssh omastar 'pqos -a llc:1=10'
ssh omastar '/home/schramm/build-linux-kernel-test2.sh 100000'

./mg-bench.sh -f 1 -n L00003-1 -r $INTERVAL -c linux
./mg-bench.sh -f 100 -n L00003-100 -r $INTERVAL -c linux
./mg-bench.sh -f 10000 -n L00003-10000 -r $INTERVAL -c linux

ssh omastar '/home/schramm/unbind-linux-routing.sh'
ssh omastar 'pqos -R'
ssh omastar 'pqos -e llc:1=0x00007'
ssh omastar 'pqos -a llc:1=10'
ssh omastar '/home/schramm/build-linux-kernel-test2.sh 100000'

./mg-bench.sh -f 1 -n L00007-1 -r $INTERVAL -c linux
./mg-bench.sh -f 100 -n L00007-100 -r $INTERVAL -c linux
./mg-bench.sh -f 10000 -n L00007-10000 -r $INTERVAL -c linux

ssh omastar '/home/schramm/unbind-linux-routing.sh'
ssh omastar 'pqos -R'
ssh omastar 'pqos -e llc:1=0x0000f'
ssh omastar 'pqos -a llc:1=10'
ssh omastar '/home/schramm/build-linux-kernel-test2.sh 100000'

./mg-bench.sh -f 1 -n L0000f-1 -r $INTERVAL -c linux
./mg-bench.sh -f 100 -n L0000f-100 -r $INTERVAL -c linux
./mg-bench.sh -f 10000 -n L0000f-10000 -r $INTERVAL -c linux

ssh omastar '/home/schramm/unbind-linux-routing.sh'
ssh omastar 'pqos -R'
ssh omastar 'pqos -e llc:1=0x0001f'
ssh omastar 'pqos -a llc:1=10'
ssh omastar '/home/schramm/build-linux-kernel-test2.sh 100000'

./mg-bench.sh -f 1 -n L0001f-1 -r $INTERVAL -c linux
./mg-bench.sh -f 100 -n L0001f-100 -r $INTERVAL -c linux
./mg-bench.sh -f 10000 -n L0001f-10000 -r $INTERVAL -c linux

ssh omastar '/home/schramm/unbind-linux-routing.sh'
ssh omastar 'pqos -R'
ssh omastar 'pqos -e llc:1=0x0003f'
ssh omastar 'pqos -a llc:1=10'
ssh omastar '/home/schramm/build-linux-kernel-test2.sh 100000'

./mg-bench.sh -f 1 -n L0003f-1 -r $INTERVAL -c linux
./mg-bench.sh -f 100 -n L0003f-100 -r $INTERVAL -c linux
./mg-bench.sh -f 10000 -n L0003f-10000 -r $INTERVAL -c linux

ssh omastar '/home/schramm/unbind-linux-routing.sh'
ssh omastar 'pqos -R'
ssh omastar 'pqos -e llc:1=0x0007f'
ssh omastar 'pqos -a llc:1=10'
ssh omastar '/home/schramm/build-linux-kernel-test2.sh 100000'

./mg-bench.sh -f 1 -n L0007f-1 -r $INTERVAL -c linux
./mg-bench.sh -f 100 -n L0007f-100 -r $INTERVAL -c linux
./mg-bench.sh -f 10000 -n L0007f-10000 -r $INTERVAL -c linux

ssh omastar '/home/schramm/unbind-linux-routing.sh'
ssh omastar 'pqos -R'
ssh omastar 'pqos -e llc:1=0x000ff'
ssh omastar 'pqos -a llc:1=10'
ssh omastar '/home/schramm/build-linux-kernel-test2.sh 100000'

./mg-bench.sh -f 1 -n L000ff-1 -r $INTERVAL -c linux
./mg-bench.sh -f 100 -n L000ff-100 -r $INTERVAL -c linux
./mg-bench.sh -f 10000 -n L000ff-10000 -r $INTERVAL -c linux

ssh omastar '/home/schramm/unbind-linux-routing.sh'
ssh omastar 'pqos -R'
ssh omastar 'pqos -e llc:1=0x001ff'
ssh omastar 'pqos -a llc:1=10'
ssh omastar '/home/schramm/build-linux-kernel-test2.sh 100000'

./mg-bench.sh -f 1 -n L001ff-1 -r $INTERVAL -c linux
./mg-bench.sh -f 100 -n L001ff-100 -r $INTERVAL -c linux
./mg-bench.sh -f 10000 -n L001ff-10000 -r $INTERVAL -c linux

ssh omastar '/home/schramm/unbind-linux-routing.sh'
ssh omastar 'pqos -R'
ssh omastar 'pqos -e llc:1=0x003ff'
ssh omastar 'pqos -a llc:1=10'
ssh omastar '/home/schramm/build-linux-kernel-test2.sh 100000'

./mg-bench.sh -f 1 -n L003ff-1 -r $INTERVAL -c linux
./mg-bench.sh -f 100 -n L003ff-100 -r $INTERVAL -c linux
./mg-bench.sh -f 10000 -n L003ff-10000 -r $INTERVAL -c linux

ssh omastar '/home/schramm/unbind-linux-routing.sh'
ssh omastar 'pqos -R'
ssh omastar 'pqos -e llc:1=0x007ff'
ssh omastar 'pqos -a llc:1=10'
ssh omastar '/home/schramm/build-linux-kernel-test2.sh 100000'

./mg-bench.sh -f 1 -n L007ff-1 -r $INTERVAL -c linux
./mg-bench.sh -f 100 -n L007ff-100 -r $INTERVAL -c linux
./mg-bench.sh -f 10000 -n L007ff-10000 -r $INTERVAL -c linux

ssh omastar '/home/schramm/unbind-linux-routing.sh'
ssh omastar 'pqos -R'
ssh omastar 'pqos -e llc:1=0x00fff'
ssh omastar 'pqos -a llc:1=10'
ssh omastar '/home/schramm/build-linux-kernel-test2.sh 100000'

./mg-bench.sh -f 1 -n L00fff-1 -r $INTERVAL -c linux
./mg-bench.sh -f 100 -n L00fff-100 -r $INTERVAL -c linux
./mg-bench.sh -f 10000 -n L00fff-10000 -r $INTERVAL -c linux

ssh omastar '/home/schramm/unbind-linux-routing.sh'
ssh omastar 'pqos -R'
ssh omastar 'pqos -e llc:1=0x01fff'
ssh omastar 'pqos -a llc:1=10'
ssh omastar '/home/schramm/build-linux-kernel-test2.sh 100000'

./mg-bench.sh -f 1 -n L01fff-1 -r $INTERVAL -c linux
./mg-bench.sh -f 100 -n L01fff-100 -r $INTERVAL -c linux
./mg-bench.sh -f 10000 -n L01fff-10000 -r $INTERVAL -c linux

ssh omastar '/home/schramm/unbind-linux-routing.sh'
ssh omastar 'pqos -R'
ssh omastar 'pqos -e llc:1=0x03fff'
ssh omastar 'pqos -a llc:1=10'
ssh omastar '/home/schramm/build-linux-kernel-test2.sh 100000'

./mg-bench.sh -f 1 -n L03fff-1 -r $INTERVAL -c linux
./mg-bench.sh -f 100 -n L03fff-100 -r $INTERVAL -c linux
./mg-bench.sh -f 10000 -n L03fff-10000 -r $INTERVAL -c linux

ssh omastar '/home/schramm/unbind-linux-routing.sh'
ssh omastar 'pqos -R'
ssh omastar 'pqos -e llc:1=0x07fff'
ssh omastar 'pqos -a llc:1=10'
ssh omastar '/home/schramm/build-linux-kernel-test2.sh 100000'

./mg-bench.sh -f 1 -n L07fff-1 -r $INTERVAL -c linux
./mg-bench.sh -f 100 -n L07fff-100 -r $INTERVAL -c linux
./mg-bench.sh -f 10000 -n L07fff-10000 -r $INTERVAL -c linux

ssh omastar '/home/schramm/unbind-linux-routing.sh'
ssh omastar 'pqos -R'
ssh omastar 'pqos -e llc:1=0x0ffff'
ssh omastar 'pqos -a llc:1=10'
ssh omastar '/home/schramm/build-linux-kernel-test2.sh 100000'

./mg-bench.sh -f 1 -n L0ffff-1 -r $INTERVAL -c linux
./mg-bench.sh -f 100 -n L0ffff-100 -r $INTERVAL -c linux
./mg-bench.sh -f 10000 -n L0ffff-10000 -r $INTERVAL -c linux

ssh omastar '/home/schramm/unbind-linux-routing.sh'
ssh omastar 'pqos -R'
ssh omastar 'pqos -e llc:1=0x1ffff'
ssh omastar 'pqos -a llc:1=10'
ssh omastar '/home/schramm/build-linux-kernel-test2.sh 100000'

./mg-bench.sh -f 1 -n L1ffff-1 -r $INTERVAL -c linux
./mg-bench.sh -f 100 -n L1ffff-100 -r $INTERVAL -c linux
./mg-bench.sh -f 10000 -n L1ffff-10000 -r $INTERVAL -c linux

ssh omastar '/home/schramm/unbind-linux-routing.sh'
ssh omastar 'pqos -R'
ssh omastar 'pqos -e llc:1=0x3ffff'
ssh omastar 'pqos -a llc:1=10'
ssh omastar '/home/schramm/build-linux-kernel-test2.sh 100000'

./mg-bench.sh -f 1 -n L3ffff-1 -r $INTERVAL -c linux
./mg-bench.sh -f 100 -n L3ffff-100 -r $INTERVAL -c linux
./mg-bench.sh -f 10000 -n L3ffff-10000 -r $INTERVAL -c linux

ssh omastar '/home/schramm/unbind-linux-routing.sh'
ssh omastar 'pqos -R'
ssh omastar 'pqos -e llc:1=0x7ffff'
ssh omastar 'pqos -a llc:1=10'
ssh omastar '/home/schramm/build-linux-kernel-test2.sh 100000'

./mg-bench.sh -f 1 -n L7ffff-1 -r $INTERVAL -c linux
./mg-bench.sh -f 100 -n L7ffff-100 -r $INTERVAL -c linux
./mg-bench.sh -f 10000 -n L7ffff-10000 -r $INTERVAL -c linux

ssh omastar '/home/schramm/unbind-linux-routing.sh'
ssh omastar 'pqos -R'
ssh omastar 'pqos -e llc:1=0xfffff'
ssh omastar 'pqos -a llc:1=10'
ssh omastar '/home/schramm/build-linux-kernel-test2.sh 100000'

./mg-bench.sh -f 1 -n Lfffff-1 -r $INTERVAL -c linux
./mg-bench.sh -f 100 -n Lfffff-100 -r $INTERVAL -c linux
./mg-bench.sh -f 10000 -n Lfffff-10000 -r $INTERVAL -c linux

ssh omastar '/home/schramm/unbind-linux-routing.sh'
ssh omastar 'pqos -R'
ssh omastar 'cp /home/schramm/00-header-org /etc/update-motd.d/00-header'

END=`date +%s`
DURATION=$(($END - $START))
HDURATION=$(($DURATION / 3600))
echo "Messung dauerte  $DURATION Sekunden oder $HDURATION Stunden"

exit 0

