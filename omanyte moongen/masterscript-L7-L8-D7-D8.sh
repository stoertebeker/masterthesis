#!/bin/bash

START=`date +%s`
INTERVAL=" 5300 7500 100"
INTERVAL2=" 100 1000 50"

cd /home/schramm
ssh omastar 'cp /home/schramm/00-header-mod /etc/update-motd.d/00-header'
ssh omastar 'modprobe msr ; pqos -R'
ssh omastar '/home/schramm/unbind-linux-routing.sh'
#ssh omastar '/home/schramm/disable-turbo-offloading.sh'
ssh omastar 'pqos -e llc:1=0xffff0'
ssh omastar 'pqos -e llc:2=0x0000f'
ssh omastar 'pqos -a llc:1=10'
ssh omastar 'pqos -a llc:2=0-9,11-39'
ssh omastar '/home/schramm/build-linux-kernel-test2.sh'

./mg-bench.sh -f 1 -n L7-000001 -r $INTERVAL2 -c linux
./mg-bench.sh -f 1000 -n L7-001000 -r $INTERVAL2 -c linux
./mg-bench.sh -f 50000 -n L7-050000 -r $INTERVAL2 -c linux
./mg-bench.sh -f 100000 -n L7-100000 -r $INTERVAL2 -c linux
./mg-bench.sh -f 250000 -n L7-250000 -r $INTERVAL2 -c linux
./mg-bench.sh -f 500000 -n L7-500000 -r $INTERVAL2 -c linux

ssh omastar '/home/schramm/unbind-linux-routing.sh'
ssh omastar 'pqos -R'
ssh omastar 'pqos -e llc:1=0xffff0'
ssh omastar 'pqos -e llc:2=0x0000f'
ssh omastar 'pqos -a llc:1=10'
ssh omastar 'pqos -a llc:2=0-9,11-39'
ssh omastar '/home/schramm/build-linux-kernel-test2.sh'
ssh omastar '/home/schramm/stress.sh 21600 linux'

./mg-bench.sh -f 1 -n L8-000001 -r $INTERVAL2 -c linux
./mg-bench.sh -f 1000 -n L8-001000 -r $INTERVAL2 -c linux
./mg-bench.sh -f 50000 -n L8-050000 -r $INTERVAL2 -c linux
./mg-bench.sh -f 100000 -n L8-100000 -r $INTERVAL2 -c linux
./mg-bench.sh -f 250000 -n L8-250000 -r $INTERVAL2 -c linux
./mg-bench.sh -f 500000 -n L8-500000 -r $INTERVAL2 -c linux

ssh omastar '/usr/bin/killall stress-ng'
ssh omastar '/home/schramm/unbind-linux-routing.sh'
ssh omastar 'pqos -R'

#ssh omastar '/home/schramm/dpdk-table-gen.sh 600000 5 > /root/dpdk/examples/l3fwd-acl/rule_ipv4.db'
#ssh omastar '/home/schramm/disable-turbo-offloading.sh'
ssh omastar 'pqos -e llc:1=0xffff0'
ssh omastar 'pqos -e llc:2=0x0000f'
ssh omastar 'pqos -a llc:1=11'
ssh omastar 'pqos -a llc:2=0-10,12-39'
ssh omastar '/usr/bin/screen -AmdS dpdk /root/dpdk/examples/l3fwd-acl/build/l3fwd-acl -c 0x800 -n 4 -- -p 0x30 --config="(4,0,11),(5,0,11)" --rule_ipv4="/root/dpdk/examples/l3fwd-acl/rule_ipv4.db" --rule_ipv6="/root/dpdk/examples/l3fwd-acl/rule_ipv6.db" --scalar'
sleep 60

./mg-bench.sh -f 1 -n D7-000001 -r $INTERVAL -c dpdk
./mg-bench.sh -f 1000 -n D7-001000 -r $INTERVAL -c dpdk
./mg-bench.sh -f 50000 -n D7-050000 -r $INTERVAL -c dpdk
./mg-bench.sh -f 100000 -n D7-100000 -r $INTERVAL -c dpdk
./mg-bench.sh -f 250000 -n D7-250000 -r $INTERVAL -c dpdk
./mg-bench.sh -f 500000 -n D7-500000 -r $INTERVAL -c dpdk

ssh omastar '/usr/bin/killall stress-ng'
ssh omastar 'screen -S dpdk -p 0 -X quit'
ssh omastar 'pqos -e llc:1=0xffff0'
ssh omastar 'pqos -e llc:2=0x0000f'
ssh omastar 'pqos -a llc:1=11'
ssh omastar 'pqos -a llc:2=0-10,12-39'
ssh omastar '/usr/bin/screen -AmdS dpdk /root/dpdk/examples/l3fwd-acl/build/l3fwd-acl -c 0x800 -n 4 -- -p 0x30 --config="(4,0,11),(5,0,11)" --rule_ipv4="/root/dpdk/examples/l3fwd-acl/rule_ipv4.db" --rule_ipv6="/root/dpdk/examples/l3fwd-acl/rule_ipv6.db" --scalar'
sleep 60
ssh omastar '/home/schramm/stress.sh 21600 dpdk'

./mg-bench.sh -f 1 -n D8-000001 -r $INTERVAL -c dpdk
./mg-bench.sh -f 1000 -n D8-001000 -r $INTERVAL -c dpdk
./mg-bench.sh -f 50000 -n D8-050000 -r $INTERVAL -c dpdk
./mg-bench.sh -f 100000 -n D8-100000 -r $INTERVAL -c dpdk
./mg-bench.sh -f 250000 -n D8-250000 -r $INTERVAL -c dpdk
./mg-bench.sh -f 500000 -n D8-500000 -r $INTERVAL -c dpdk

ssh omastar '/usr/bin/killall stress-ng'
ssh omastar 'screen -S dpdk -p 0 -X quit'
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

