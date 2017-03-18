#!/bin/bash

## Variablen definieren
a=10
b=0
c=1
d=10
#IF_DST=1

## Aufbau der IP: a.b.c.d

#MAC des Senders auf Moongen

arp -i ens5f0 -s 10.0.0.10 90:E2:BA:7E:9F:6C
arp -i ens5f1 -s 10.0.1.2 90:E2:BA:7E:9F:6D

## Methoden beschreiben
make_table(){
	## Solange Counter noch nicht auf Null
	while [ $entries -gt 0 ]
       do
		## Ausgabe des Strings
		#echo "R$a.$b.$c.$d/32 10.0.1.10/8 0 : 65535 0 : 65535 0x00/0x00 $IF_DST"
		#route add -net $a.$b.$c.$d netmask 255.255.255.255 dev ens5f1
		ip route add $a.$b.$c.$d via 10.0.1.2
		## letzten Block der IP nochzählen
		d=$(($d+1))

		## Falls d-Block bei 255 angekommen ist, Zähler dafür zurücksetzen und c-Block um Eins erhöhen
		if [ $d -eq 256 ]
			then d=0 ; c=$(($c+1))
		fi

                ## Falls c-Block bei 255 angekommen ist, Zähler dafür zurücksetzen und b-Block um Eins erhöhen
		if [ $c -eq 256 ]
			then c=0 ; b=$(($b+1))
		fi

		## Falls b-Block bei 255 angekommen ist, beende Programm, da maximal möglicher Adressraum beschrieben ist (10.255.255.255)
		if [ $b -eq 256 ]
                        then echo "mehr geht nicht!" ; exit
		fi

		## Counter dekrementieren
		entries=$(($entries-1))
       done
}

## starte Programm mit Überprüfung der Eingabe
if [ -z "$1" ]
        then
		echo "Keine Anzahl angegeben!"
		echo "Syntax: table-gen.sh Anzahl_IPs [Destination_Port]"
		exit 1
        else
		if [ -n "$2" ]
			then IF_DST=($2)
		fi
	entries=($1) ; make_table
fi
