#!/bin/bash

START=`date +%s`
INTERVAL=" 5500 7000 100"
INTERVAL2=" 4000 7000 100"

cd /home/schramm
ssh omastar 'cp /home/schramm/00-header-mod /etc/update-motd.d/00-header'
ssh omastar 'modprobe msr ; pqos -R'
ssh omastar 'screen -S dpdk -p 0 -X quit'
ssh omastar '/home/schramm/dpdk-table-gen.sh 600000 5 > /root/dpdk/examples/l3fwd-acl/rule_ipv4.db'
ssh omastar '/home/schramm/disable-turbo-offloading.sh'

ssh omastar 'pqos -e llc:1=0x00001'
ssh omastar 'pqos -a llc:1=11'
ssh omastar '/usr/bin/screen -AmdS dpdk /root/dpdk/examples/l3fwd-acl/build/l3fwd-acl -c 0x800 -n 4 -- -p 0x30 --config="(4,0,11),(5,0,11)" --rule_ipv4="/root/dpdk/examples/l3fwd-acl/rule_ipv4.db" --rule_ipv6="/root/dpdk/examples/l3fwd-acl/rule_ipv6.db" --scalar'

./mg-bench.sh -f 10000 -n D00001-10000 -r $INTERVAL2 -c dpdk
./mg-bench.sh -f 100000 -n D00001-100000 -r $INTERVAL2 -c dpdk

ssh omastar 'screen -S dpdk -p 0 -X quit'
ssh omastar 'pqos -e llc:1=0x00003'
ssh omastar 'pqos -a llc:1=11'
ssh omastar '/usr/bin/screen -AmdS dpdk /root/dpdk/examples/l3fwd-acl/build/l3fwd-acl -c 0x800 -n 4 -- -p 0x30 --config="(4,0,11),(5,0,11)" --rule_ipv4="/root/dpdk/examples/l3fwd-acl/rule_ipv4.db" --rule_ipv6="/root/dpdk/examples/l3fwd-acl/rule_ipv6.db" --scalar'

./mg-bench.sh -f 10000 -n D00003-10000 -r $INTERVAL2 -c dpdk
./mg-bench.sh -f 100000 -n D00003-100000 -r $INTERVAL2 -c dpdk

ssh omastar 'screen -S dpdk -p 0 -X quit'
ssh omastar 'pqos -e llc:1=0x00007'
ssh omastar 'pqos -a llc:1=11'
ssh omastar '/usr/bin/screen -AmdS dpdk /root/dpdk/examples/l3fwd-acl/build/l3fwd-acl -c 0x800 -n 4 -- -p 0x30 --config="(4,0,11),(5,0,11)" --rule_ipv4="/root/dpdk/examples/l3fwd-acl/rule_ipv4.db" --rule_ipv6="/root/dpdk/examples/l3fwd-acl/rule_ipv6.db" --scalar'

./mg-bench.sh -f 10000 -n D00007-10000 -r $INTERVAL -c dpdk
./mg-bench.sh -f 100000 -n D00007-100000 -r $INTERVAL -c dpdk

ssh omastar 'screen -S dpdk -p 0 -X quit'
ssh omastar 'pqos -e llc:1=0x0000f'
ssh omastar 'pqos -a llc:1=11'
ssh omastar '/usr/bin/screen -AmdS dpdk /root/dpdk/examples/l3fwd-acl/build/l3fwd-acl -c 0x800 -n 4 -- -p 0x30 --config="(4,0,11),(5,0,11)" --rule_ipv4="/root/dpdk/examples/l3fwd-acl/rule_ipv4.db" --rule_ipv6="/root/dpdk/examples/l3fwd-acl/rule_ipv6.db" --scalar'

./mg-bench.sh -f 10000 -n D0000f-10000 -r $INTERVAL -c dpdk
./mg-bench.sh -f 100000 -n D0000f-100000 -r $INTERVAL -c dpdk

ssh omastar 'screen -S dpdk -p 0 -X quit'
ssh omastar 'pqos -e llc:1=0x0001f'
ssh omastar 'pqos -a llc:1=11'
ssh omastar '/usr/bin/screen -AmdS dpdk /root/dpdk/examples/l3fwd-acl/build/l3fwd-acl -c 0x800 -n 4 -- -p 0x30 --config="(4,0,11),(5,0,11)" --rule_ipv4="/root/dpdk/examples/l3fwd-acl/rule_ipv4.db" --rule_ipv6="/root/dpdk/examples/l3fwd-acl/rule_ipv6.db" --scalar'

./mg-bench.sh -f 10000 -n D0001f-10000 -r $INTERVAL -c dpdk
./mg-bench.sh -f 100000 -n D0001f-100000 -r $INTERVAL -c dpdk

ssh omastar 'screen -S dpdk -p 0 -X quit'
ssh omastar 'pqos -e llc:1=0x0003f'
ssh omastar 'pqos -a llc:1=11'
ssh omastar '/usr/bin/screen -AmdS dpdk /root/dpdk/examples/l3fwd-acl/build/l3fwd-acl -c 0x800 -n 4 -- -p 0x30 --config="(4,0,11),(5,0,11)" --rule_ipv4="/root/dpdk/examples/l3fwd-acl/rule_ipv4.db" --rule_ipv6="/root/dpdk/examples/l3fwd-acl/rule_ipv6.db" --scalar'

./mg-bench.sh -f 10000 -n D0003f-10000 -r $INTERVAL -c dpdk
./mg-bench.sh -f 100000 -n D0003f-100000 -r $INTERVAL -c dpdk

ssh omastar 'screen -S dpdk -p 0 -X quit'
ssh omastar 'pqos -e llc:1=0x0007f'
ssh omastar 'pqos -a llc:1=11'
ssh omastar '/usr/bin/screen -AmdS dpdk /root/dpdk/examples/l3fwd-acl/build/l3fwd-acl -c 0x800 -n 4 -- -p 0x30 --config="(4,0,11),(5,0,11)" --rule_ipv4="/root/dpdk/examples/l3fwd-acl/rule_ipv4.db" --rule_ipv6="/root/dpdk/examples/l3fwd-acl/rule_ipv6.db" --scalar'

./mg-bench.sh -f 10000 -n D0007f-10000 -r $INTERVAL -c dpdk
./mg-bench.sh -f 100000 -n D0007f-100000 -r $INTERVAL -c dpdk

ssh omastar 'screen -S dpdk -p 0 -X quit'
ssh omastar 'pqos -e llc:1=0x000ff'
ssh omastar 'pqos -a llc:1=11'
ssh omastar '/usr/bin/screen -AmdS dpdk /root/dpdk/examples/l3fwd-acl/build/l3fwd-acl -c 0x800 -n 4 -- -p 0x30 --config="(4,0,11),(5,0,11)" --rule_ipv4="/root/dpdk/examples/l3fwd-acl/rule_ipv4.db" --rule_ipv6="/root/dpdk/examples/l3fwd-acl/rule_ipv6.db" --scalar'

./mg-bench.sh -f 10000 -n D000ff-10000 -r $INTERVAL -c dpdk
./mg-bench.sh -f 100000 -n D000ff-100000 -r $INTERVAL -c dpdk

ssh omastar 'screen -S dpdk -p 0 -X quit'
ssh omastar 'pqos -e llc:1=0x001ff'
ssh omastar 'pqos -a llc:1=11'
ssh omastar '/usr/bin/screen -AmdS dpdk /root/dpdk/examples/l3fwd-acl/build/l3fwd-acl -c 0x800 -n 4 -- -p 0x30 --config="(4,0,11),(5,0,11)" --rule_ipv4="/root/dpdk/examples/l3fwd-acl/rule_ipv4.db" --rule_ipv6="/root/dpdk/examples/l3fwd-acl/rule_ipv6.db" --scalar'

./mg-bench.sh -f 10000 -n D001ff-10000 -r $INTERVAL -c dpdk
./mg-bench.sh -f 100000 -n D001ff-100000 -r $INTERVAL -c dpdk

ssh omastar 'screen -S dpdk -p 0 -X quit'
ssh omastar 'pqos -e llc:1=0x003ff'
ssh omastar 'pqos -a llc:1=11'
ssh omastar '/usr/bin/screen -AmdS dpdk /root/dpdk/examples/l3fwd-acl/build/l3fwd-acl -c 0x800 -n 4 -- -p 0x30 --config="(4,0,11),(5,0,11)" --rule_ipv4="/root/dpdk/examples/l3fwd-acl/rule_ipv4.db" --rule_ipv6="/root/dpdk/examples/l3fwd-acl/rule_ipv6.db" --scalar'

./mg-bench.sh -f 10000 -n D003ff-10000 -r $INTERVAL -c dpdk
./mg-bench.sh -f 100000 -n D003ff-100000 -r $INTERVAL -c dpdk

ssh omastar 'screen -S dpdk -p 0 -X quit'
ssh omastar 'pqos -e llc:1=0x007ff'
ssh omastar 'pqos -a llc:1=11'
ssh omastar '/usr/bin/screen -AmdS dpdk /root/dpdk/examples/l3fwd-acl/build/l3fwd-acl -c 0x800 -n 4 -- -p 0x30 --config="(4,0,11),(5,0,11)" --rule_ipv4="/root/dpdk/examples/l3fwd-acl/rule_ipv4.db" --rule_ipv6="/root/dpdk/examples/l3fwd-acl/rule_ipv6.db" --scalar'

./mg-bench.sh -f 10000 -n D007ff-10000 -r $INTERVAL -c dpdk
./mg-bench.sh -f 100000 -n D007ff-100000 -r $INTERVAL -c dpdk

ssh omastar 'screen -S dpdk -p 0 -X quit'
ssh omastar 'pqos -e llc:1=0x00fff'
ssh omastar 'pqos -a llc:1=11'
ssh omastar '/usr/bin/screen -AmdS dpdk /root/dpdk/examples/l3fwd-acl/build/l3fwd-acl -c 0x800 -n 4 -- -p 0x30 --config="(4,0,11),(5,0,11)" --rule_ipv4="/root/dpdk/examples/l3fwd-acl/rule_ipv4.db" --rule_ipv6="/root/dpdk/examples/l3fwd-acl/rule_ipv6.db" --scalar'

./mg-bench.sh -f 10000 -n D00fff-10000 -r $INTERVAL -c dpdk
./mg-bench.sh -f 100000 -n D00fff-100000 -r $INTERVAL -c dpdk

ssh omastar 'screen -S dpdk -p 0 -X quit'
ssh omastar 'pqos -e llc:1=0x01fff'
ssh omastar 'pqos -a llc:1=11'
ssh omastar '/usr/bin/screen -AmdS dpdk /root/dpdk/examples/l3fwd-acl/build/l3fwd-acl -c 0x800 -n 4 -- -p 0x30 --config="(4,0,11),(5,0,11)" --rule_ipv4="/root/dpdk/examples/l3fwd-acl/rule_ipv4.db" --rule_ipv6="/root/dpdk/examples/l3fwd-acl/rule_ipv6.db" --scalar'

./mg-bench.sh -f 10000 -n D01fff-10000 -r $INTERVAL -c dpdk
./mg-bench.sh -f 100000 -n D01fff-100000 -r $INTERVAL -c dpdk

ssh omastar 'screen -S dpdk -p 0 -X quit'
ssh omastar 'pqos -e llc:1=0x03fff'
ssh omastar 'pqos -a llc:1=11'
ssh omastar '/usr/bin/screen -AmdS dpdk /root/dpdk/examples/l3fwd-acl/build/l3fwd-acl -c 0x800 -n 4 -- -p 0x30 --config="(4,0,11),(5,0,11)" --rule_ipv4="/root/dpdk/examples/l3fwd-acl/rule_ipv4.db" --rule_ipv6="/root/dpdk/examples/l3fwd-acl/rule_ipv6.db" --scalar'

./mg-bench.sh -f 10000 -n D03fff-10000 -r $INTERVAL -c dpdk
./mg-bench.sh -f 100000 -n D03fff-100000 -r $INTERVAL -c dpdk

ssh omastar 'screen -S dpdk -p 0 -X quit'
ssh omastar 'pqos -e llc:1=0x07fff'
ssh omastar 'pqos -a llc:1=11'
ssh omastar '/usr/bin/screen -AmdS dpdk /root/dpdk/examples/l3fwd-acl/build/l3fwd-acl -c 0x800 -n 4 -- -p 0x30 --config="(4,0,11),(5,0,11)" --rule_ipv4="/root/dpdk/examples/l3fwd-acl/rule_ipv4.db" --rule_ipv6="/root/dpdk/examples/l3fwd-acl/rule_ipv6.db" --scalar'

./mg-bench.sh -f 10000 -n D07fff-10000 -r $INTERVAL -c dpdk
./mg-bench.sh -f 100000 -n D07fff-100000 -r $INTERVAL -c dpdk

ssh omastar 'screen -S dpdk -p 0 -X quit'
ssh omastar 'pqos -e llc:1=0x0ffff'
ssh omastar 'pqos -a llc:1=11'
ssh omastar '/usr/bin/screen -AmdS dpdk /root/dpdk/examples/l3fwd-acl/build/l3fwd-acl -c 0x800 -n 4 -- -p 0x30 --config="(4,0,11),(5,0,11)" --rule_ipv4="/root/dpdk/examples/l3fwd-acl/rule_ipv4.db" --rule_ipv6="/root/dpdk/examples/l3fwd-acl/rule_ipv6.db" --scalar'

./mg-bench.sh -f 10000 -n D0ffff-10000 -r $INTERVAL -c dpdk
./mg-bench.sh -f 100000 -n D0ffff-100000 -r $INTERVAL -c dpdk

ssh omastar 'screen -S dpdk -p 0 -X quit'
ssh omastar 'pqos -e llc:1=0x1ffff'
ssh omastar 'pqos -a llc:1=11'
ssh omastar '/usr/bin/screen -AmdS dpdk /root/dpdk/examples/l3fwd-acl/build/l3fwd-acl -c 0x800 -n 4 -- -p 0x30 --config="(4,0,11),(5,0,11)" --rule_ipv4="/root/dpdk/examples/l3fwd-acl/rule_ipv4.db" --rule_ipv6="/root/dpdk/examples/l3fwd-acl/rule_ipv6.db" --scalar'

./mg-bench.sh -f 10000 -n D1ffff-10000 -r $INTERVAL -c dpdk
./mg-bench.sh -f 100000 -n D1ffff-100000 -r $INTERVAL -c dpdk

ssh omastar 'screen -S dpdk -p 0 -X quit'
ssh omastar 'pqos -e llc:1=0x3ffff'
ssh omastar 'pqos -a llc:1=11'
ssh omastar '/usr/bin/screen -AmdS dpdk /root/dpdk/examples/l3fwd-acl/build/l3fwd-acl -c 0x800 -n 4 -- -p 0x30 --config="(4,0,11),(5,0,11)" --rule_ipv4="/root/dpdk/examples/l3fwd-acl/rule_ipv4.db" --rule_ipv6="/root/dpdk/examples/l3fwd-acl/rule_ipv6.db" --scalar'

./mg-bench.sh -f 10000 -n D3ffff-10000 -r $INTERVAL -c dpdk
./mg-bench.sh -f 100000 -n D3ffff-100000 -r $INTERVAL -c dpdk

ssh omastar 'screen -S dpdk -p 0 -X quit'
ssh omastar 'pqos -e llc:1=0x7ffff'
ssh omastar 'pqos -a llc:1=11'
ssh omastar '/usr/bin/screen -AmdS dpdk /root/dpdk/examples/l3fwd-acl/build/l3fwd-acl -c 0x800 -n 4 -- -p 0x30 --config="(4,0,11),(5,0,11)" --rule_ipv4="/root/dpdk/examples/l3fwd-acl/rule_ipv4.db" --rule_ipv6="/root/dpdk/examples/l3fwd-acl/rule_ipv6.db" --scalar'

./mg-bench.sh -f 10000 -n D7ffff-10000 -r $INTERVAL -c dpdk
./mg-bench.sh -f 100000 -n D7ffff-100000 -r $INTERVAL -c dpdk

ssh omastar 'screen -S dpdk -p 0 -X quit'
ssh omastar 'pqos -e llc:1=0xfffff'
ssh omastar 'pqos -a llc:1=11'
ssh omastar '/usr/bin/screen -AmdS dpdk /root/dpdk/examples/l3fwd-acl/build/l3fwd-acl -c 0x800 -n 4 -- -p 0x30 --config="(4,0,11),(5,0,11)" --rule_ipv4="/root/dpdk/examples/l3fwd-acl/rule_ipv4.db" --rule_ipv6="/root/dpdk/examples/l3fwd-acl/rule_ipv6.db" --scalar'

./mg-bench.sh -f 10000 -n Dfffff-10000 -r $INTERVAL -c dpdk
./mg-bench.sh -f 100000 -n Dfffff-100000 -r $INTERVAL -c dpdk

ssh omastar 'screen -S dpdk -p 0 -X quit'
ssh omastar 'pqos -R'
ssh omastar 'cp /home/schramm/00-header-org /etc/update-motd.d/00-header'

END=`date +%s`
DURATION=$(($END - $START))
HDURATION=$(($DURATION / 3600))
echo "Messung dauerte  $DURATION Sekunden oder $HDURATION Stunden"

exit 0


