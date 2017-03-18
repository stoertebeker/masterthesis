#!/bin/bash

ifconfig ens5f1 down
ifconfig ens5f0 down
ifconfig ens4f0 down
ifconfig ens4f1 down
ifconfig enp4s0f0 down
ifconfig enp4s0f1 down
/root/MoonGen/bind-interfaces.sh
