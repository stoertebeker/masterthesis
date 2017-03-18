#!/bin/bash

##############
# Achtung! Dieses Script hat fest definierte Variablen und kann nicht ohne Anpassung ausgeführt werden!
# Device under Test heisst omastar, dort müssen ssh-keys für root hinterlegt sein
# Lastgenerator heisst omanyte, script muss als root ausgeführt werden
# Autor: Norbert Schramm
# Mail: schramm.norbert@t-online.de
##############

#Die folgenden Variablen können/müssen editiert werden
export MG_PATH="/home/schramm/MoonGen"
export RESULTS_DIR="/tmp"
export TIME=30
export OUT="2"
export IN="3"
export SIZE=64

#Die folgenden Variablen stellen Default-Werte dar, welche durch Parameter überschrieben werden können
export DELTA_RATE=50
export MIN_RATE=50
export MAX_RATE=1500
export DATE=`date +%Y-%m-%d:%H:%M:%S`
export FLOWS=99999
export MGRUN=yes
export RESULTS="results_`date +%Y-%m-%d_%H_%M_%S`/omanyte"
export LIKWID_RUN="yes" #nicht verändern

# Übergebene Variablen
READOPT=0
while [ $READOPT -eq 0 ] ; do
	case $1 in
		-f) export FLOWS=$2 ; shift
		    echo "Übergebene Flows: $FLOWS"
		    shift ;;
		-s) export SIZE=$2 ; shift
		    echo "Paketgröße: $SIZE"
		    shift ;;
		-n) export RESULTS=$2_results_$SIZE/omanyte ; shift
		    echo "Sitzungsname: $RESULTS"
		    shift ;;
		-l) export MGRUN=no
		    shift ;;
		-h) echo "Usage:"
		    echo "-c : Coremask; linux oder dpdk"
		    echo "-f : Anzahl Flows"
		    echo "-l : führt mg-bench ohne moongen aus"
		    echo "-s : Paketgröße, Default 64"
		    echo "-r : Intervallmessung: #von #bis #intervall in MBits"
		    echo "-n : Sitzungsname"
		    echo "-in : Moongen-port eingehend"
		    echo "-out : Moongen-port, ausgehend" 
		    exit
		    shift ;;
		-r) export MIN_RATE=$2 ; shift
		    export MAX_RATE=$2 ; shift
		    export DELTA_RATE=$2 ; shift
		    echo "Es wird von  $MIN_RATE MBits bis $MAX_RATE MBits in $DELTA_RATE MBits Abständen gemessen"
		    shift ;;
		-c) export CMASK=$2 ; shift
		    echo "Coremask fuer $CMASK gewaehlt"
		    shift ;;
		-in) export IN=$2 ; shift
		     echo "eingehender Moongen-Port: $IN"
		     shift ;;
		-out) export OUT=$2 ; shift
		      echo "ausgehender Moongen-Port: $OUT"
		      shift ;;
    		*) if `echo $1 | grep -s '^-'` ; then # Parm. beginnt mit '-'
            		echo "unknown option $1"
            		shift
          	      else
            		READOPT=1  # Ende Optionen, kein shift!
          	      fi   ;;
  	esac
done

## actual test starts here
RATE=$MIN_RATE
RATES=$RATE
NUM_RUNS=0
while (( $(bc <<< "$RATE < $MAX_RATE ") )) ; do
	RATE=$(($RATE + $DELTA_RATE))
	RATES="$RATES $RATE"
	NUM_RUNS=$(($NUM_RUNS + 1))
done

#Ausgabe zu erwartender Laufzeit in Abhängigkeit von der Anzahl der Messungen 
export DURATION=$((((($MAX_RATE - $MIN_RATE) / $DELTA_RATE) * $TIME) / 60 ))
echo "Der Test dauert $DURATION Minuten"

cd $MG_PATH
export RESULTS_PATH=$RESULTS_DIR/$RESULTS
#Ordner fuer Testergebnisse erstellen falls noch nicht vorhanden
if [ ! -d $RESULTS_PATH ]
  then
    mkdir -p $RESULTS_PATH
    echo "Ordner $RESULTS_PATH für Ergebnisse erstellt"
fi

#Ordner auf Omastar fuer likwid mounten zum auslesen und kopieren der Ergebnisse
rm -rf /home/schramm/omastar/*
sshfs omastar:/home/schramm/results_likwid /home/schramm/omastar

echo "Benchmark on $DATE with $FLOWS flows" >> $RESULTS_PATH/testlauf.txt

i=1
#Benchmark-Schleife
for RATE in $RATES ; do

	#Likwid-Aufruf
	if [ "$CMASK" == "dpdk" ]
	then
		echo "Lauf $i mit $RATE MBits ###################################" >> /home/schramm/omastar/likwid-run.txt
		ssh omastar 'sleep 5 & taskset 0x800 likwid-perfctr -c 11 -g L3MEM -g L3 -T 1s sleep 30 >> /home/schramm/results_likwid/likwid-run.txt &'
		echo "likwid gestartet"
	elif [ "$CMASK" == "linux" ]
	then
                echo "Lauf $i mit $RATE MBits ###################################" >> /home/schramm/omastar/likwid-run.txt
                ssh omastar 'sleep 5 & likwid-perfctr -c 11 -g L3MEM -g L3 -T 1s sleep 30 >> /home/schramm/results_likwid/likwid-run.txt &'
                echo "likwid gestartet"
	else
		echo "Ungültige Core-Mask. Likwid wird nicht ausgeführt"
		export LIKWID_RUN=no
	fi

	#Moongen-Aufruf
	if [ "$MGRUN" == "yes" ] # Nur likwid wird ausgeführt ohne moongen, nützlich um z.B. nur stress-ng zu messen
	then
	        echo "------------------------------------------" >> $RESULTS_PATH/testlauf.txt
	        echo "Test run $i with $RATE Mbits wit $SIZE Byte Packet Size started" | tee -a  $RESULTS_PATH/testlauf.txt
	        echo "./build/MoonGen ./examples/l3-load-latency.lua $OUT $IN -f $FLOWS -r $RATE -s $SIZE -t $TIME "
		./build/MoonGen ./examples/l3-load-latency.lua $OUT $IN -f $FLOWS -r $RATE -s $SIZE -t $TIME | tee $RESULTS_PATH/mg-raw-$RATE-$i.txt | grep StdDev | grep Device | cut -d, -f 1,2 >> $RESULTS_PATH/testlauf.txt
		mv ./histogram.csv $RESULTS_PATH/hist_$RATE.csv
		i=$((i+1))
	else
		echo "nur schlafen"
		sleep $TIME
	fi
done
echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~" >> $RESULTS_PATH/testlauf.txt
echo "" >> $RESULTS_PATH/testlauf.txt

#Likwid-Datei auf omastar verschieben und mount entfernen
if [ "$LIKWID_RUN" == "yes" ]
then
	mv /home/schramm/omastar/likwid-run.txt $RESULTS_PATH/likwid-run.txt
fi
umount /home/schramm/omastar

echo "finish at `date +%Y-%m-%d:%H:%M:%S`"