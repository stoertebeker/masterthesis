#!/bin/bash
INTERVAL=" 5500 7000 100"
INTERVAL2="4000 6000 100"
INTERVAL3="5500	7000 100"
START=`date +%s`

cd /home/schramm
ssh omastar 'cp /home/schramm/00-header-mod /etc/update-motd.d/00-header'
ssh omastar 'modprobe msr ; pqos -R'
ssh omastar '/home/schramm/unbind-linux-routing.sh'
ssh omastar '/home/schramm/dpdk-table-gen.sh 600000 5 > /root/dpdk/examples/l3fwd-acl/rule_ipv4.db'
#ssh omastar '/home/schramm/disable-turbo-offloading.sh'
ssh omastar '/usr/bin/screen -AmdS dpdk /root/dpdk/examples/l3fwd-acl/build/l3fwd-acl -c 0x800 -n 4 -- -p 0x30 --config="(4,0,11),(5,0,11)" --rule_ipv4="/root/dpdk/examples/l3fwd-acl/rule_ipv4.db" --rule_ipv6="/root/dpdk/examples/l3fwd-acl/rule_ipv6.db" --scalar'
sleep 60

./mg-bench.sh -f 1 -n D1-000001 -r $INTERVAL -c dpdk
./mg-bench.sh -f 1000 -n D1-001000 -r $INTERVAL -c dpdk
./mg-bench.sh -f 50000 -n D1-050000 -r $INTERVAL -c dpdk
./mg-bench.sh -f 100000 -n D1-100000 -r $INTERVAL -c dpdk
./mg-bench.sh -f 250000 -n D1-250000 -r $INTERVAL -c dpdk
./mg-bench.sh -f 500000 -n D1-500000 -r $INTERVAL -c dpdk

ssh omastar 'screen -S dpdk -p 0 -X quit'
ssh omastar 'pqos -e llc:1=0x00001'
ssh omastar 'pqos -a llc:1=11'
ssh omastar '/usr/bin/screen -AmdS dpdk /root/dpdk/examples/l3fwd-acl/build/l3fwd-acl -c 0x800 -n 4 -- -p 0x30 --config="(4,0,11),(5,0,11)" --rule_ipv4="/root/dpdk/examples/l3fwd-acl/rule_ipv4.db" --rule_ipv6="/root/dpdk/examples/l3fwd-acl/rule_ipv6.db" --scalar'
sleep 60

./mg-bench.sh -f 1 -n D2-000001 -r $INTERVAL2 -c dpdk
./mg-bench.sh -f 1000 -n D2-001000 -r $INTERVAL2 -c dpdk
./mg-bench.sh -f 50000 -n D2-050000 -r $INTERVAL2 -c dpdk
./mg-bench.sh -f 100000 -n D2-100000 -r $INTERVAL2 -c dpdk
./mg-bench.sh -f 250000 -n D2-250000 -r $INTERVAL2 -c dpdk
./mg-bench.sh -f 500000 -n D2-500000 -r $INTERVAL2 -c dpdk

ssh omastar 'screen -S dpdk -p 0 -X quit'
ssh omastar 'pqos -e llc:1=0x0000f'
ssh omastar 'pqos -a llc:1=11'
ssh omastar '/usr/bin/screen -AmdS dpdk /root/dpdk/examples/l3fwd-acl/build/l3fwd-acl -c 0x800 -n 4 -- -p 0x30 --config="(4,0,11),(5,0,11)" --rule_ipv4="/root/dpdk/examples/l3fwd-acl/rule_ipv4.db" --rule_ipv6="/root/dpdk/examples/l3fwd-acl/rule_ipv6.db" --scalar'
sleep 60

./mg-bench.sh -f 1 -n D3-000001 -r $INTERVAL3 -c dpdk
./mg-bench.sh -f 1000 -n D3-001000 -r $INTERVAL3 -c dpdk
./mg-bench.sh -f 50000 -n D3-050000 -r $INTERVAL3 -c dpdk
./mg-bench.sh -f 100000 -n D3-100000 -r $INTERVAL3 -c dpdk
./mg-bench.sh -f 250000 -n D3-250000 -r $INTERVAL3 -c dpdk
./mg-bench.sh -f 500000 -n D3-500000 -r $INTERVAL3 -c dpdk

ssh omastar 'screen -S dpdk -p 0 -X quit'
ssh omastar 'pqos -R'
ssh omastar 'cp /home/schramm/00-header-org /etc/update-motd.d/00-header'

END=`date +%s`
DURATION=$(($END - $START))
HDURATION=$(($DURATION / 3600))
echo "Messung dauerte  $DURATION Sekunden oder $HDURATION Stunden"

exit 0
