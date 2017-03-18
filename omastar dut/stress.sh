#!/bin/bash
s="s"
if [ -z "$1" ]
	then stime=120
	else stime=($1)
fi

if [ "$2" == linux ]
    then echo "core 11 wird ausgelassen"
	CORES=0-9,11-29,31-39
	echo "Core-Mask: $CORES"
    elif [ "$2" == "dpdk" ]
        then echo "core 12 wird ausgelassen"
	CORES=0-10,12-30,32-39
	echo "Core-Mask: $CORES"
    elif [ "$2" == "benchmark" ]
        then echo "Nur core 10-19"
        CORES=10-19
        echo "Core-Mask: $CORES"

fi

/usr/bin/screen -AmdS stress1 stress-ng --taskset $CORES --cache 90 --cache-flush --cache-prefetch --aggressive --cpu 2 --cpu-method matrixprod --timeout $stime$s --metrics-brief
/usr/bin/screen -AmdS stress2 stress-ng --taskset $CORES --cache 90 --cache-flush --cache-prefetch --aggressive --cpu 2 --cpu-method matrixprod --timeout $stime$s --metrics-brief
/usr/bin/screen -AmdS stress3 stress-ng --taskset $CORES --cache 90 --cache-flush --cache-prefetch --aggressive --cpu 2 --cpu-method matrixprod --timeout $stime$s --metrics-brief
echo "maximaler Stress für $stime Sekunden."
stime=$(($stime - 5))
#sleep 5
#while [ $stime -gt 0 ]
#	do
#	echo "Noch $stime Sekunden"
#	stime=$(($stime - 5))
#	sleep 5
#done
