#!/bin/bash

pqos -R
pqos -e llc:1=0x00001;
#pqos -e llc:2=0xffffe;
pqos -a llc:1=10-11
#pqos -a llc:2=6-39
pqos -s

