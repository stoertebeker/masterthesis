#!/bin/bash

START=`date +%s`
INTERVAL=" 4000 7000 100"

cd /home/schramm
ssh omastar 'cp /home/schramm/00-header-mod /etc/update-motd.d/00-header'
ssh omastar 'modprobe msr ; pqos -R'
ssh omastar 'screen -S dpdk -p 0 -X quit'
ssh omastar '/home/schramm/dpdk-table-gen.sh 600000 5 > /root/dpdk/examples/l3fwd-acl/rule_ipv4.db'
ssh omastar '/home/schramm/disable-turbo-offloading.sh'

ssh omastar 'pqos -e llc:1=0x00001'
ssh omastar 'pqos -a llc:1=11'
ssh omastar '/usr/bin/screen -AmdS dpdk /root/dpdk/examples/l3fwd-acl/build/l3fwd-acl -c 0x800 -n 4 -- -p 0x30 --config="(4,0,11),(5,0,11)" --rule_ipv4="/root/dpdk/examples/l3fwd-acl/rule_ipv4.db" --rule_ipv6="/root/dpdk/examples/l3fwd-acl/rule_ipv6.db" --scalar'

./mg-bench.sh -f 1 -n D00001-1 -r $INTERVAL -c dpdk
./mg-bench.sh -f 50000 -n D00001-50000 -r $INTERVAL -c dpdk
./mg-bench.sh -f 500000 -n D00001-500000 -r $INTERVAL -c dpdk

ssh omastar 'screen -S dpdk -p 0 -X quit'
ssh omastar 'pqos -e llc:1=0x00003'
ssh omastar 'pqos -a llc:1=11'
ssh omastar '/usr/bin/screen -AmdS dpdk /root/dpdk/examples/l3fwd-acl/build/l3fwd-acl -c 0x800 -n 4 -- -p 0x30 --config="(4,0,11),(5,0,11)" --rule_ipv4="/root/dpdk/examples/l3fwd-acl/rule_ipv4.db" --rule_ipv6="/root/dpdk/examples/l3fwd-acl/rule_ipv6.db" --scalar'

./mg-bench.sh -f 1 -n D00003-1 -r $INTERVAL -c dpdk
./mg-bench.sh -f 50000 -n D00003-50000 -r $INTERVAL -c dpdk
./mg-bench.sh -f 500000 -n D00003-500000 -r $INTERVAL -c dpdk

ssh omastar 'screen -S dpdk -p 0 -X quit'
ssh omastar 'pqos -e llc:1=0x00007'
ssh omastar 'pqos -a llc:1=11'
ssh omastar '/usr/bin/screen -AmdS dpdk /root/dpdk/examples/l3fwd-acl/build/l3fwd-acl -c 0x800 -n 4 -- -p 0x30 --config="(4,0,11),(5,0,11)" --rule_ipv4="/root/dpdk/examples/l3fwd-acl/rule_ipv4.db" --rule_ipv6="/root/dpdk/examples/l3fwd-acl/rule_ipv6.db" --scalar'

./mg-bench.sh -f 1 -n D00007-1 -r $INTERVAL -c dpdk
./mg-bench.sh -f 50000 -n D00007-50000 -r $INTERVAL -c dpdk
./mg-bench.sh -f 500000 -n D00007-500000 -r $INTERVAL -c dpdk

ssh omastar 'screen -S dpdk -p 0 -X quit'
ssh omastar 'pqos -e llc:1=0x0000f'
ssh omastar 'pqos -a llc:1=11'
ssh omastar '/usr/bin/screen -AmdS dpdk /root/dpdk/examples/l3fwd-acl/build/l3fwd-acl -c 0x800 -n 4 -- -p 0x30 --config="(4,0,11),(5,0,11)" --rule_ipv4="/root/dpdk/examples/l3fwd-acl/rule_ipv4.db" --rule_ipv6="/root/dpdk/examples/l3fwd-acl/rule_ipv6.db" --scalar'

./mg-bench.sh -f 1 -n D0000f-1 -r $INTERVAL -c dpdk
./mg-bench.sh -f 50000 -n D0000f-50000 -r $INTERVAL -c dpdk
./mg-bench.sh -f 500000 -n D0000f-500000 -r $INTERVAL -c dpdk

ssh omastar 'screen -S dpdk -p 0 -X quit'
ssh omastar 'pqos -e llc:1=0x0001f'
ssh omastar 'pqos -a llc:1=11'
ssh omastar '/usr/bin/screen -AmdS dpdk /root/dpdk/examples/l3fwd-acl/build/l3fwd-acl -c 0x800 -n 4 -- -p 0x30 --config="(4,0,11),(5,0,11)" --rule_ipv4="/root/dpdk/examples/l3fwd-acl/rule_ipv4.db" --rule_ipv6="/root/dpdk/examples/l3fwd-acl/rule_ipv6.db" --scalar'

./mg-bench.sh -f 1 -n D0001f-1 -r $INTERVAL -c dpdk
./mg-bench.sh -f 50000 -n D0001f-50000 -r $INTERVAL -c dpdk
./mg-bench.sh -f 500000 -n D0001f-500000 -r $INTERVAL -c dpdk

ssh omastar 'screen -S dpdk -p 0 -X quit'
ssh omastar 'pqos -e llc:1=0x0003f'
ssh omastar 'pqos -a llc:1=11'
ssh omastar '/usr/bin/screen -AmdS dpdk /root/dpdk/examples/l3fwd-acl/build/l3fwd-acl -c 0x800 -n 4 -- -p 0x30 --config="(4,0,11),(5,0,11)" --rule_ipv4="/root/dpdk/examples/l3fwd-acl/rule_ipv4.db" --rule_ipv6="/root/dpdk/examples/l3fwd-acl/rule_ipv6.db" --scalar'

./mg-bench.sh -f 1 -n D0003f-1 -r $INTERVAL -c dpdk
./mg-bench.sh -f 50000 -n D0003f-50000 -r $INTERVAL -c dpdk
./mg-bench.sh -f 500000 -n D0003f-500000 -r $INTERVAL -c dpdk

ssh omastar 'screen -S dpdk -p 0 -X quit'
ssh omastar 'pqos -e llc:1=0x0007f'
ssh omastar 'pqos -a llc:1=11'
ssh omastar '/usr/bin/screen -AmdS dpdk /root/dpdk/examples/l3fwd-acl/build/l3fwd-acl -c 0x800 -n 4 -- -p 0x30 --config="(4,0,11),(5,0,11)" --rule_ipv4="/root/dpdk/examples/l3fwd-acl/rule_ipv4.db" --rule_ipv6="/root/dpdk/examples/l3fwd-acl/rule_ipv6.db" --scalar'

./mg-bench.sh -f 1 -n D0007f-1 -r $INTERVAL -c dpdk
./mg-bench.sh -f 50000 -n D0007f-50000 -r $INTERVAL -c dpdk
./mg-bench.sh -f 500000 -n D0007f-500000 -r $INTERVAL -c dpdk

ssh omastar 'screen -S dpdk -p 0 -X quit'
ssh omastar 'pqos -e llc:1=0x000ff'
ssh omastar 'pqos -a llc:1=11'
ssh omastar '/usr/bin/screen -AmdS dpdk /root/dpdk/examples/l3fwd-acl/build/l3fwd-acl -c 0x800 -n 4 -- -p 0x30 --config="(4,0,11),(5,0,11)" --rule_ipv4="/root/dpdk/examples/l3fwd-acl/rule_ipv4.db" --rule_ipv6="/root/dpdk/examples/l3fwd-acl/rule_ipv6.db" --scalar'

./mg-bench.sh -f 1 -n D000ff-1 -r $INTERVAL -c dpdk
./mg-bench.sh -f 50000 -n D000ff-50000 -r $INTERVAL -c dpdk
./mg-bench.sh -f 500000 -n D000ff-500000 -r $INTERVAL -c dpdk

ssh omastar 'screen -S dpdk -p 0 -X quit'
ssh omastar 'pqos -e llc:1=0x001ff'
ssh omastar 'pqos -a llc:1=11'
ssh omastar '/usr/bin/screen -AmdS dpdk /root/dpdk/examples/l3fwd-acl/build/l3fwd-acl -c 0x800 -n 4 -- -p 0x30 --config="(4,0,11),(5,0,11)" --rule_ipv4="/root/dpdk/examples/l3fwd-acl/rule_ipv4.db" --rule_ipv6="/root/dpdk/examples/l3fwd-acl/rule_ipv6.db" --scalar'

./mg-bench.sh -f 1 -n D001ff-1 -r $INTERVAL -c dpdk
./mg-bench.sh -f 50000 -n D001ff-50000 -r $INTERVAL -c dpdk
./mg-bench.sh -f 500000 -n D001ff-500000 -r $INTERVAL -c dpdk

ssh omastar 'screen -S dpdk -p 0 -X quit'
ssh omastar 'pqos -e llc:1=0x003ff'
ssh omastar 'pqos -a llc:1=11'
ssh omastar '/usr/bin/screen -AmdS dpdk /root/dpdk/examples/l3fwd-acl/build/l3fwd-acl -c 0x800 -n 4 -- -p 0x30 --config="(4,0,11),(5,0,11)" --rule_ipv4="/root/dpdk/examples/l3fwd-acl/rule_ipv4.db" --rule_ipv6="/root/dpdk/examples/l3fwd-acl/rule_ipv6.db" --scalar'

./mg-bench.sh -f 1 -n D003ff-1 -r $INTERVAL -c dpdk
./mg-bench.sh -f 50000 -n D003ff-50000 -r $INTERVAL -c dpdk
./mg-bench.sh -f 500000 -n D003ff-500000 -r $INTERVAL -c dpdk

ssh omastar 'screen -S dpdk -p 0 -X quit'
ssh omastar 'pqos -e llc:1=0x007ff'
ssh omastar 'pqos -a llc:1=11'
ssh omastar '/usr/bin/screen -AmdS dpdk /root/dpdk/examples/l3fwd-acl/build/l3fwd-acl -c 0x800 -n 4 -- -p 0x30 --config="(4,0,11),(5,0,11)" --rule_ipv4="/root/dpdk/examples/l3fwd-acl/rule_ipv4.db" --rule_ipv6="/root/dpdk/examples/l3fwd-acl/rule_ipv6.db" --scalar'

./mg-bench.sh -f 1 -n D007ff-1 -r $INTERVAL -c dpdk
./mg-bench.sh -f 50000 -n D007ff-50000 -r $INTERVAL -c dpdk
./mg-bench.sh -f 500000 -n D007ff-500000 -r $INTERVAL -c dpdk

ssh omastar 'screen -S dpdk -p 0 -X quit'
ssh omastar 'pqos -e llc:1=0x00fff'
ssh omastar 'pqos -a llc:1=11'
ssh omastar '/usr/bin/screen -AmdS dpdk /root/dpdk/examples/l3fwd-acl/build/l3fwd-acl -c 0x800 -n 4 -- -p 0x30 --config="(4,0,11),(5,0,11)" --rule_ipv4="/root/dpdk/examples/l3fwd-acl/rule_ipv4.db" --rule_ipv6="/root/dpdk/examples/l3fwd-acl/rule_ipv6.db" --scalar'

./mg-bench.sh -f 1 -n D00fff-1 -r $INTERVAL -c dpdk
./mg-bench.sh -f 50000 -n D00fff-50000 -r $INTERVAL -c dpdk
./mg-bench.sh -f 500000 -n D00fff-500000 -r $INTERVAL -c dpdk

ssh omastar 'screen -S dpdk -p 0 -X quit'
ssh omastar 'pqos -e llc:1=0x01fff'
ssh omastar 'pqos -a llc:1=11'
ssh omastar '/usr/bin/screen -AmdS dpdk /root/dpdk/examples/l3fwd-acl/build/l3fwd-acl -c 0x800 -n 4 -- -p 0x30 --config="(4,0,11),(5,0,11)" --rule_ipv4="/root/dpdk/examples/l3fwd-acl/rule_ipv4.db" --rule_ipv6="/root/dpdk/examples/l3fwd-acl/rule_ipv6.db" --scalar'

./mg-bench.sh -f 1 -n D01fff-1 -r $INTERVAL -c dpdk
./mg-bench.sh -f 50000 -n D01fff-50000 -r $INTERVAL -c dpdk
./mg-bench.sh -f 500000 -n D01fff-500000 -r $INTERVAL -c dpdk

ssh omastar 'screen -S dpdk -p 0 -X quit'
ssh omastar 'pqos -e llc:1=0x03fff'
ssh omastar 'pqos -a llc:1=11'
ssh omastar '/usr/bin/screen -AmdS dpdk /root/dpdk/examples/l3fwd-acl/build/l3fwd-acl -c 0x800 -n 4 -- -p 0x30 --config="(4,0,11),(5,0,11)" --rule_ipv4="/root/dpdk/examples/l3fwd-acl/rule_ipv4.db" --rule_ipv6="/root/dpdk/examples/l3fwd-acl/rule_ipv6.db" --scalar'

./mg-bench.sh -f 1 -n D03fff-1 -r $INTERVAL -c dpdk
./mg-bench.sh -f 50000 -n D03fff-50000 -r $INTERVAL -c dpdk
./mg-bench.sh -f 500000 -n D03fff-500000 -r $INTERVAL -c dpdk

ssh omastar 'screen -S dpdk -p 0 -X quit'
ssh omastar 'pqos -e llc:1=0x07fff'
ssh omastar 'pqos -a llc:1=11'
ssh omastar '/usr/bin/screen -AmdS dpdk /root/dpdk/examples/l3fwd-acl/build/l3fwd-acl -c 0x800 -n 4 -- -p 0x30 --config="(4,0,11),(5,0,11)" --rule_ipv4="/root/dpdk/examples/l3fwd-acl/rule_ipv4.db" --rule_ipv6="/root/dpdk/examples/l3fwd-acl/rule_ipv6.db" --scalar'

./mg-bench.sh -f 1 -n D07fff-1 -r $INTERVAL -c dpdk
./mg-bench.sh -f 50000 -n D07fff-50000 -r $INTERVAL -c dpdk
./mg-bench.sh -f 500000 -n D07fff-500000 -r $INTERVAL -c dpdk

ssh omastar 'screen -S dpdk -p 0 -X quit'
ssh omastar 'pqos -e llc:1=0x0ffff'
ssh omastar 'pqos -a llc:1=11'
ssh omastar '/usr/bin/screen -AmdS dpdk /root/dpdk/examples/l3fwd-acl/build/l3fwd-acl -c 0x800 -n 4 -- -p 0x30 --config="(4,0,11),(5,0,11)" --rule_ipv4="/root/dpdk/examples/l3fwd-acl/rule_ipv4.db" --rule_ipv6="/root/dpdk/examples/l3fwd-acl/rule_ipv6.db" --scalar'

./mg-bench.sh -f 1 -n D0ffff-1 -r $INTERVAL -c dpdk
./mg-bench.sh -f 50000 -n D0ffff-50000 -r $INTERVAL -c dpdk
./mg-bench.sh -f 500000 -n D0ffff-500000 -r $INTERVAL -c dpdk

ssh omastar 'screen -S dpdk -p 0 -X quit'
ssh omastar 'pqos -e llc:1=0x1ffff'
ssh omastar 'pqos -a llc:1=11'
ssh omastar '/usr/bin/screen -AmdS dpdk /root/dpdk/examples/l3fwd-acl/build/l3fwd-acl -c 0x800 -n 4 -- -p 0x30 --config="(4,0,11),(5,0,11)" --rule_ipv4="/root/dpdk/examples/l3fwd-acl/rule_ipv4.db" --rule_ipv6="/root/dpdk/examples/l3fwd-acl/rule_ipv6.db" --scalar'

./mg-bench.sh -f 1 -n D1ffff-1 -r $INTERVAL -c dpdk
./mg-bench.sh -f 50000 -n D1ffff-50000 -r $INTERVAL -c dpdk
./mg-bench.sh -f 500000 -n D1ffff-500000 -r $INTERVAL -c dpdk

ssh omastar 'screen -S dpdk -p 0 -X quit'
ssh omastar 'pqos -e llc:1=0x3ffff'
ssh omastar 'pqos -a llc:1=11'
ssh omastar '/usr/bin/screen -AmdS dpdk /root/dpdk/examples/l3fwd-acl/build/l3fwd-acl -c 0x800 -n 4 -- -p 0x30 --config="(4,0,11),(5,0,11)" --rule_ipv4="/root/dpdk/examples/l3fwd-acl/rule_ipv4.db" --rule_ipv6="/root/dpdk/examples/l3fwd-acl/rule_ipv6.db" --scalar'

./mg-bench.sh -f 1 -n D3ffff-1 -r $INTERVAL -c dpdk
./mg-bench.sh -f 50000 -n D3ffff-50000 -r $INTERVAL -c dpdk
./mg-bench.sh -f 500000 -n D3ffff-500000 -r $INTERVAL -c dpdk

ssh omastar 'screen -S dpdk -p 0 -X quit'
ssh omastar 'pqos -e llc:1=0x7ffff'
ssh omastar 'pqos -a llc:1=11'
ssh omastar '/usr/bin/screen -AmdS dpdk /root/dpdk/examples/l3fwd-acl/build/l3fwd-acl -c 0x800 -n 4 -- -p 0x30 --config="(4,0,11),(5,0,11)" --rule_ipv4="/root/dpdk/examples/l3fwd-acl/rule_ipv4.db" --rule_ipv6="/root/dpdk/examples/l3fwd-acl/rule_ipv6.db" --scalar'

./mg-bench.sh -f 1 -n D7ffff-1 -r $INTERVAL -c dpdk
./mg-bench.sh -f 50000 -n D7ffff-50000 -r $INTERVAL -c dpdk
./mg-bench.sh -f 500000 -n D7ffff-500000 -r $INTERVAL -c dpdk

ssh omastar 'screen -S dpdk -p 0 -X quit'
ssh omastar 'pqos -e llc:1=0xfffff'
ssh omastar 'pqos -a llc:1=11'
ssh omastar '/usr/bin/screen -AmdS dpdk /root/dpdk/examples/l3fwd-acl/build/l3fwd-acl -c 0x800 -n 4 -- -p 0x30 --config="(4,0,11),(5,0,11)" --rule_ipv4="/root/dpdk/examples/l3fwd-acl/rule_ipv4.db" --rule_ipv6="/root/dpdk/examples/l3fwd-acl/rule_ipv6.db" --scalar'

./mg-bench.sh -f 1 -n Dfffff-1 -r $INTERVAL -c dpdk
./mg-bench.sh -f 50000 -n Dfffff-50000 -r $INTERVAL -c dpdk
./mg-bench.sh -f 500000 -n Dfffff-500000 -r $INTERVAL -c dpdk

ssh omastar 'screen -S dpdk -p 0 -X quit'
ssh omastar 'pqos -R'
ssh omastar 'cp /home/schramm/00-header-org /etc/update-motd.d/00-header'

END=`date +%s`
DURATION=$(($END - $START))
HDURATION=$(($DURATION / 3600))
echo "Messung dauerte  $DURATION Sekunden oder $HDURATION Stunden"

exit 0

