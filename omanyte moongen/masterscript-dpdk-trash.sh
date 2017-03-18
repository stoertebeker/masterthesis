#!/bin/bash
INTERVAL=" 5000 7000 100"
INTERVAL2="4000 6500 100"
INTERVAL3="4500	6500 100"
START=`date +%s`

cd /home/schramm
ssh omastar 'cp /home/schramm/00-header-mod /etc/update-motd.d/00-header'
ssh omastar 'modprobe msr ; pqos -R'
ssh omastar '/usr/bin/killall stress-ng'
ssh omastar '/home/schramm/unbind-linux-routing.sh'
#ssh omastar '/home/schramm/dpdk-table-gen.sh 600000 5 > /root/dpdk/examples/l3fwd-acl/rule_ipv4.db'
#ssh omastar '/home/schramm/disable-turbo-offloading.sh'
ssh omastar '/usr/bin/screen -AmdS dpdk /root/dpdk/examples/l3fwd-acl/build/l3fwd-acl -c 0x800 -n 4 -- -p 0x30 --config="(4,0,11),(5,0,11)" --rule_ipv4="/root/dpdk/examples/l3fwd-acl/rule_ipv4.db" --rule_ipv6="/root/dpdk/examples/l3fwd-acl/rule_ipv6.db" --scalar'
sleep 60
ssh omastar '/home/schramm/stress.sh 21600 dpdk'

./mg-bench.sh -f 1 -n D4-000001 -r $INTERVAL -c dpdk
./mg-bench.sh -f 1000 -n D4-001000 -r $INTERVAL -c dpdk
./mg-bench.sh -f 50000 -n D4-050000 -r $INTERVAL -c dpdk
./mg-bench.sh -f 100000 -n D4-100000 -r $INTERVAL -c dpdk
./mg-bench.sh -f 250000 -n D4-250000 -r $INTERVAL -c dpdk
./mg-bench.sh -f 500000 -n D4-500000 -r $INTERVAL -c dpdk

ssh omastar '/usr/bin/killall stress-ng'
ssh omastar 'screen -S dpdk -p 0 -X quit'
ssh omastar 'pqos -e llc:1=0x00001'
ssh omastar 'pqos -e llc:2=0xffffe'
ssh omastar 'pqos -a llc:1=11'
ssh omastar 'pqos -a llc:2=0-10,12-39'
ssh omastar '/usr/bin/screen -AmdS dpdk /root/dpdk/examples/l3fwd-acl/build/l3fwd-acl -c 0x800 -n 4 -- -p 0x30 --config="(4,0,11),(5,0,11)" --rule_ipv4="/root/dpdk/examples/l3fwd-acl/rule_ipv4.db" --rule_ipv6="/root/dpdk/examples/l3fwd-acl/rule_ipv6.db" --scalar'
sleep 60
ssh omastar '/home/schramm/stress.sh 21600 dpdk'

./mg-bench.sh -f 1 -n D5-000001 -r $INTERVAL2 -c dpdk
./mg-bench.sh -f 1000 -n D5-001000 -r $INTERVAL2 -c dpdk
./mg-bench.sh -f 50000 -n D5-050000 -r $INTERVAL2 -c dpdk
./mg-bench.sh -f 100000 -n D5-100000 -r $INTERVAL2 -c dpdk
./mg-bench.sh -f 250000 -n D5-250000 -r $INTERVAL2 -c dpdk
./mg-bench.sh -f 500000 -n D5-500000 -r $INTERVAL2 -c dpdk

ssh omastar '/usr/bin/killall stress-ng'
ssh omastar 'screen -S dpdk -p 0 -X quit'
ssh omastar 'pqos -e llc:1=0x0000f'
ssh omastar 'pqos -e llc:2=0xffff'
ssh omastar 'pqos -a llc:1=11'
ssh omastar 'pqos -a llc:2=0-10,12-39'
ssh omastar '/usr/bin/screen -AmdS dpdk /root/dpdk/examples/l3fwd-acl/build/l3fwd-acl -c 0x800 -n 4 -- -p 0x30 --config="(4,0,11),(5,0,11)" --rule_ipv4="/root/dpdk/examples/l3fwd-acl/rule_ipv4.db" --rule_ipv6="/root/dpdk/examples/l3fwd-acl/rule_ipv6.db" --scalar'
sleep 60
ssh omastar '/home/schramm/stress.sh 21600 dpdk'

./mg-bench.sh -f 1 -n D6-000001 -r $INTERVAL3 -c dpdk
./mg-bench.sh -f 1000 -n D6-001000 -r $INTERVAL3 -c dpdk
./mg-bench.sh -f 50000 -n D6-050000 -r $INTERVAL3 -c dpdk
./mg-bench.sh -f 100000 -n D6-100000 -r $INTERVAL3 -c dpdk
./mg-bench.sh -f 250000 -n D6-250000 -r $INTERVAL3 -c dpdk
./mg-bench.sh -f 500000 -n D6-500000 -r $INTERVAL3 -c dpdk

ssh omastar '/usr/bin/killall stress-ng'
ssh omastar 'screen -S dpdk -p 0 -X quit'
ssh omastar 'pqos -R'
ssh omastar 'cp /home/schramm/00-header-org /etc/update-motd.d/00-header'

END=`date +%s`
DURATION=$(($END - $START))
HDURATION=$(($DURATION / 3600))
echo "Messung dauerte  $DURATION Sekunden oder $HDURATION Stunden"

exit 0
