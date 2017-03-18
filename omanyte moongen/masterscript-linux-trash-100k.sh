#!/bin/bash

START=`date +%s`
INTERVAL=" 100 1500 50"

cd /home/schramm
ssh omastar 'cp /home/schramm/00-header-mod /etc/update-motd.d/00-header'
ssh omastar 'modprobe msr ; pqos -R'
ssh omastar '/usr/bin/killall stress-ng'
ssh omastar '/home/schramm/unbind-linux-routing.sh'
ssh omastar '/home/schramm/build-linux-kernel-test2.sh 100001'
ssh omastar '/home/schramm/disable-turbo-offloading.sh'
ssh omastar '/home/schramm/stress.sh 21600 linux'
sleep 10

./mg-bench.sh -f 1 -n L14-000001 -r $INTERVAL -c linux
./mg-bench.sh -f 10 -n L14-000010 -r $INTERVAL -c linux
./mg-bench.sh -f 100 -n L14-000100 -r $INTERVAL -c linux
./mg-bench.sh -f 1000 -n L14-001000 -r $INTERVAL -c linux
./mg-bench.sh -f 10000 -n L14-010000 -r $INTERVAL -c linux
./mg-bench.sh -f 100000 -n L14-100000 -r $INTERVAL -c linux

ssh omastar '/usr/bin/killall stress-ng'
ssh omastar '/home/schramm/unbind-linux-routing.sh'
ssh omastar 'pqos -e llc:1=0x00001'
ssh omastar 'pqos -e llc:2=0xffffe'
ssh omastar 'pqos -a llc:1=10'
ssh omastar 'pqos -a llc:2=0-9,11-39'
ssh omastar '/home/schramm/build-linux-kernel-test2.sh 100001'
ssh omastar '/home/schramm/stress.sh 21600 linux'

./mg-bench.sh -f 1 -n L15-000001 -r $INTERVAL -c linux
./mg-bench.sh -f 10 -n L15-000010 -r $INTERVAL -c linux
./mg-bench.sh -f 100 -n L15-000100 -r $INTERVAL -c linux
./mg-bench.sh -f 1000 -n L15-001000 -r $INTERVAL -c linux
./mg-bench.sh -f 10000 -n L15-010000 -r $INTERVAL -c linux
./mg-bench.sh -f 100000 -n L15-100000 -r $INTERVAL -c linux

ssh omastar '/usr/bin/killall stress-ng'
ssh omastar '/home/schramm/unbind-linux-routing.sh'
ssh omastar 'pqos -e llc:1=0x0000f'
ssh omastar 'pqos -e llc:2=0xffff'
ssh omastar 'pqos -a llc:1=10'
ssh omastar 'pqos -a llc:2=0-9,11-39'
ssh omastar '/home/schramm/build-linux-kernel-test2.sh 100001'
ssh omastar '/home/schramm/stress.sh 21600 linux'

./mg-bench.sh -f 1 -n L16-000001 -r $INTERVAL -c linux
./mg-bench.sh -f 10 -n L16-000010 -r $INTERVAL -c linux
./mg-bench.sh -f 100 -n L16-000100 -r $INTERVAL -c linux
./mg-bench.sh -f 1000 -n L16-001000 -r $INTERVAL -c linux
./mg-bench.sh -f 10000 -n L16-010000 -r $INTERVAL -c linux
./mg-bench.sh -f 100000 -n L16-100000 -r $INTERVAL -c linux

ssh omastar '/home/schramm/unbind-linux-routing.sh'
ssh omastar 'pqos -e llc:1=0xffff0'
ssh omastar 'pqos -e llc:2=0x0000f'
ssh omastar 'pqos -a llc:1=10'
ssh omastar 'pqos -a llc:2=0-9,11-39'
ssh omastar '/home/schramm/build-linux-kernel-test2.sh 100001'
ssh omastar '/home/schramm/stress.sh 21600 linux'

./mg-bench.sh -f 1 -n L17-000001 -r $INTERVAL -c linux
./mg-bench.sh -f 10 -n L17-000010 -r $INTERVAL -c linux
./mg-bench.sh -f 100 -n L17-000100 -r $INTERVAL -c linux
./mg-bench.sh -f 1000 -n L17-001000 -r $INTERVAL -c linux
./mg-bench.sh -f 10000 -n L17-010000 -r $INTERVAL -c linux
./mg-bench.sh -f 100000 -n L17-100000 -r $INTERVAL -c linux

ssh omastar '/usr/bin/killall stress-ng'
ssh omastar '/home/schramm/unbind-linux-routing.sh'
ssh omastar 'pqos -R'
ssh omastar 'cp /home/schramm/00-header-org /etc/update-motd.d/00-header'

END=`date +%s`
DURATION=$(($END - $START))

zeitschleife() {
    s=$1
    s_mod=$((s%60))

    if [ $s -gt 60 ]
    then
        m=$((s/60))
        m_mod=$((m%60))

        if [ $m -gt 60 ]
        then
            h=$((m/60))
            h_mod=$((h%24))

            if [ $h -gt 24 ]
            then
                d=$((h/24))
                echo " $d Tage $h_mod Stunden, $m_mod Minuten, $s_mod Sekunden"
                        else
                echo "$h_mod Stunden, $m_mod Minuten, $s_mod Sekunden"
                        fi
                else
            echo "$m_mod Minuten, $s_mod Sekunden"
                fi
        else
        echo "$s_mod Sekunden"
        fi
}

zeitschleife $DURATION

exit 0

