#!/bin/bash

START=`date +%s`

./masterscript-cachesize-linux.sh
./masterscript-cachesize-linux600.sh
./masterscript-cachesize-dpdk.sh
./masterscript-linux.sh
./masterscript-linux-trash.sh
./masterscript-dpdk.sh
./masterscript-dpdk-trash.sh
./masterscript-L7-L8-D7-D8.sh
#./masterscript-linux-100k.sh
#./masterscript-linux-trash-100k.sh
sleep 5

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

echo "Endlich fertig um `date +%Y-%m-%d:%H:%M:%S`"
echo "$0 started at `date -d @$START` and ended at `date`" >> /home/schramm/log/laufzeiten.log
