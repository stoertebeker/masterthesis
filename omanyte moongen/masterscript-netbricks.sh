#!/bin/bash
INTERVAL=" 5000 7600 200"
INTERVAL2="3000 6000 200"
INTERVAL3="4000	7000 200"
START=`date +%s`

cd /home/schramm
ssh omastar 'modprobe msr ; pqos -R'
ssh omastar '/home/schramm/unbind-linux-routing.sh'
ssh omastar '/home/schramm/disable-turbo-offloading.sh'
ssh omastar '/usr/bin/screen -AmdS netbricks /home/schramm/NetBricks/build.sh run zcsi-lpm -c 11 -m 11 -p 0000:81:00.0'
sleep 10 

./mg-bench.sh -f 1 -n N1-000001 -r $INTERVAL -in 2 -out 2
./mg-bench.sh -f 1000 -n N1-001000 -r $INTERVAL -in 2 -out 2
./mg-bench.sh -f 50000 -n N1-050000 -r $INTERVAL -in 2 -out 2
./mg-bench.sh -f 100000 -n N1-100000 -r $INTERVAL -in 2 -out 2
./mg-bench.sh -f 250000 -n N1-250000 -r $INTERVAL -in 2 -out 2
./mg-bench.sh -f 500000 -n N1-500000 -r $INTERVAL -in 2 -out 2

ssh omastar 'screen -S netbricks -p 0 -X quit'
ssh omastar 'pqos -e llc:1=0x00001'
ssh omastar 'pqos -a llc:1=11'
ssh omastar '/usr/bin/screen -AmdS netbricks /home/schramm/NetBricks/build.sh run zcsi-lpm -c 11 -m 11 -p 0000:81:00.0'
sleep 10

./mg-bench.sh -f 1 -n N2-000001 -r $INTERVAL2 -in 2 -out 2
./mg-bench.sh -f 1000 -n N2-001000 -r $INTERVAL2 -in 2 -out 2
./mg-bench.sh -f 50000 -n N2-050000 -r $INTERVAL2 -in 2 -out 2
./mg-bench.sh -f 100000 -n N2-100000 -r $INTERVAL2 -in 2 -out 2
./mg-bench.sh -f 250000 -n N2-250000 -r $INTERVAL2 -in 2 -out 2
./mg-bench.sh -f 500000 -n N2-500000 -r $INTERVAL2 -in 2 -out 2

ssh omastar 'screen -S netbricks -p 0 -X quit'
ssh omastar 'pqos -e llc:1=0x0000f'
ssh omastar 'pqos -a llc:1=11'
ssh omastar '/usr/bin/screen -AmdS netbricks /home/schramm/NetBricks/build.sh run zcsi-lpm -c 11 -m 11 -p 0000:81:00.0'
sleep 10

./mg-bench.sh -f 1 -n N3-000001 -r $INTERVAL3 -in 2 -out 2
./mg-bench.sh -f 1000 -n N3-001000 -r $INTERVAL3 -in 2 -out 2
./mg-bench.sh -f 50000 -n N3-050000 -r $INTERVAL3 -in 2 -out 2
./mg-bench.sh -f 100000 -n N3-100000 -r $INTERVAL3 -in 2 -out 2
./mg-bench.sh -f 250000 -n N3-250000 -r $INTERVAL3 -in 2 -out 2
./mg-bench.sh -f 500000 -n N3-500000 -r $INTERVAL3 -in 2 -out 2

ssh omastar 'screen -S netbricks -p 0 -X quit'
ssh omastar 'pqos -R'

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
