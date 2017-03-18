cd ~
ls
mkdir .ssh
cd .ssh/
vim authorized_keys
exit
cd ~
ls
cd .ssh/
ls
cat authorized_keys 
w
sudo ls
less /proc/cpuinfo 
lshw
auso lshw
sudo lshw
ifconfig 
ifconfig -a
ls
git clone git://dpdk.org/dpdk
less /proc/cpuinfo 
./dpdk/tools/dpdk-devbind.py -s
htop
pqos
sudo apt install intel-cmt-cat
sudo pqos
w
last
sudo apt search intel cmt
sudo apt install intel-cmt-cat
man intel-cat-cmt
history
sudo pqos
lscpu
lscpu | cat
lscpu | grep cat
lscpu | grep cmt
uname -a
htop
lscpu
sudo pqos -m all:0-11
wget home.stoerte.net:1440/linpack.tgz
tar xvzf linpack.tgz 
cd linpack_11.2.0/benchmarks/linpack/
./runme_xeon64
w
./runme_xeon64
htop
less /proc/meminfo 
pqos -s -v
sudo  modprobe msr
pqos -s -v
sudo pqos -s -v
sudo pqos -m all:0-11
sudo  pqos -r
sudo pqos -m all:0-11
w
sudo  pqos -s
sudo pqos -R
sudo pqos -m all:
sudo pqos -m all
sudo pqos -m all:10-30
w
last
ifconfig -a
sudo ethtool 
sudo ethtool -l
sudo ethtool -h
man pqos
sudo pqos -m llc:0-20
htop
sudo pqos -m llc:0-20
sudo pqos -m all:0-10
sudo pqos -m all:0-20
sudo pqos -m all:15-25
htop
sudo pqos -m all:15-30
htop
sudo pqos -m all:15-30
htop
sudo pqos -m all:15-30
top
pqos -m "mbl:0-2;mbr:3,4,5"
sudo pqos -m "mbl:0-2;mbr:3,4,5"
sudo pqos -m "all:[0-11];llc:[12,13,14];mbl:[15-17,20]"
sudo pqos -m all:[19:20]
sudo pqos -m all:[19-20]
less /proc/meminfo 
sudo lshw -short -C memory
top
sudo pqos -p all:25503
sudo pqos -r
w
htop
sudo pqos -m all:[0-1]
sudo pqos -s
sudo pqos -m all:[0-3]
sudo pqos -m all:0-3
sudo pqos -t
sudo pqos -T
sudo pqos -s
history
sudo lshw -short -C memory
sudo pqos -m all:[0-40]
sudo pqos -m all:[0-39]
htop
sudo pqos -m all:[0-39]
htop
sudo pqos -m all:[0-39]
htop
free
free -v
free -h
free -h -t
free -h -l
free -h -l -s 3
free -h -l -s 
free -h -l -w
sudo pqos -m all:[0-39]
htop
sudo pqos -m all:[0-39]
cd linpack_11.2.0/benchmarks/linpack/
tasksel 0xff ./runme_xeon64
man tasksel
taskset 0xff ./runme_xeon64
./runme_xeon64
taskset 0x3ff0000 ./runme_xeon64
taskset 0x300000 ./runme_xeon64
taskset 0x600000 ./runme_xeon64
taskset 0x180000 ./runme_xeon64
taskset 0x3 ./runme_xeon64
w
taskset 0x5 ./runme_xeon64
./runme_xeon64
taskset 0x1 ./runme_xeon64
stress -m 2
stress -m 40
stress -m 40 --vm-bytes 2048M
w
stress -m 1 --vm-bytes 2048M
stress -m 2 --vm-bytes 2048M
stress -m 4 --vm-bytes 2048M
stress -m 8 --vm-bytes 2048M
lscpu
stress -m 40 --vm-bytes 2048M
taskset 0x1 ./runme_xeon64
cd linpack_11.2.0/benchmarks/linpack/
taskset 0x1 ./runme_xeon64
man pqos 
pqos -r
sudo pqos -r
htop
sudo pqos -r
htop
sudo pqos -r
htop
sudo pqos -r -T
w
last
ls
rm linpack.tgz 
mtr 93.223.206.6     
w
sudo su
sudo -s
cat /proc/cpuinfo 
cat /dev/cpu_dma_latency 
cat /dev/cpu/0/msr 
hexdump /dev/cpu/0/msr 
cpupower 
cpupower info
powertop 
sudo apt install cpuid
cpuid 
cpuid | less
pqos -r
sudo -i
memtester 100M > /dev/zero
htop
pqos -e llc:1=0xf
pqos -e llc:1=0xf;
pqos -s
pqos -a llc:1=0-7
pqos -s
htop
pqos -r
w
sudo -s
man sudo
sudo -i
find / -name libqos
sudo find / -name libqos
sudo -i
stress --cpu 40
cd linpack_11.2.0/benchmarks/linpack/
taskset 0x3 ./runme_xeon64
stress --cpu 3
taskset 0x3 
stress --cpu 40
stress --vm 3
stress --vm 30
w
last
sudo -i
htop
stress --cpu 40
htop
pqos -e llc:1=0xf
sudo pqos -e llc:1=0xf
sudo pqos -e llc:0=0x0ffff
sudo pqos -a llc1:=0-2
sudo pqos -a llc:1=0-2
sudo pqos -s
sudo pqos -e llc:1=0xf0000
sudo pqos -s
taskset 0x1FFFFFFFFF stress --cpu 37
taskset 0xFFFFFFFFFF1 stress --cpu 37
taskset 0xFFFFFFFFFF8 stress --cpu 37
htop
sudo pqos -e llc:1=0x10000
taskset 0xFFFFFFFFFF8 stress --cpu 37
pqos -R
sudo pqos -R
taskset 0xFFFFFFFFFF8 stress --cpu 40
stress --cpu 40
sudo pqos -s
stress --cpu 40
taskset 0xFFFFFFFFFF8 stress --cpu 40
sudo pqos -R
sudo -i
cat /proc/interrupts 
last
sudo -i
w
last
stress -c 2 -i 1 -m 1 --vm-bytes 128M -t 10s
sudo -i
sudo pqos -r
lscpu
cd linpack_11.2.0/benchmarks/linpack/
w
last
taskset 0x8000080000 ./runme_xeon64
screen -AmdS bash
screen -r bash
screen -r
htop
sudo pqos -r
htop
sudo pqos -r
taskset 0xC0000 ./runme_xeon64
taskset 0x1 ./runme_xeon64
screen -r
htop
w
screen -r
w
last
w
sudo -i
cd linpack_11.2.0/benchmarks/linpack/
last
screen -r
screen -AmdS bash
screen -r
htop
lscpu
cd
sudo -i
screen -r
taskset 0x1 ./runme_xeon64
taskset ffc003ffc000 ./runme_xeon64
taskset 3FF003FF ./runme_xeon64
taskset FFFFF ./runme_xeon64
./runme_xeon64
sudo -i
htop
screen -r
htop
w
screen -r
htop
screen -r
sudo pqos -s
sudo pqos -sr
sudo pqos -r
screen -r
htop
screen -r
sudo -i
cd linpack_11.2.0/benchmarks/linpack/
./runme_xeon64
sudo -i
w
sudo init 6
htop
cat /proc/meminfo 
sudo su
sudo -i
cat /proc/meminfo 
sudo -i
cd dpdk/app/proc_info/
sudo -i
cat /proc/meminfo 
sudo -i
w
sudo -i
htop -d 0,1
sudo -i
w
sudo -i
w
sudo apt updata
sudo apt update
curl https://sh.rustup.rs -sSf | sh
dig rustup.rs
dig sh.rustup.rs
curl https://sh.rustup.rs -sSf | sh
dig @8.8.8.8 sh.rustup.rs
echo $HOME
sudo -i
sudo -s
sudo -i
ssh abakus.stoerte.net
dig abakus.stoerte.net
dig sh.rustup.rs
curl https://sh.rustup.rs -sSf | sh
source $HOME/.cargo/env
rustup install nightly
git clone https://github.com/netsys/netbricks
cd netbricks/
./build.sh 
sudo apt-get install libgnutls30 libgnutls-openssl-dev libcurl4-gnutls-dev
sudo apt-get install libsctp-dev
./build.sh 
cd ..
rm -rf netbricks/
git clone https://github.com/netsys/netbricks
last
cd netbricks/
./build.sh 
nano build.sh 
nano 3rdparty/get-dpdk.sh 
cd netbricks/
./build.sh 
sudo apt install libpcap-devel
sudo apt search libpcap
sudo apt install libpcap-dev
cd
rm -rf netbricks/
git clone https://github.com/netsys/netbricks
cd netbricks/
./build.sh 
cd ..
rm -rf netbricks/
git clone https://github.com/netsys/netbricks
cd netbricks/
sudo ./build.sh 
cd
ls
rm -rf netbricks/
sudo -s
pwd
rm -rf netbricks/
curl https://sh.rustup.rs -sSf | sh
rustup install nightly
w
uname -a
rm -rf netbricks/
sudo rm -rf netbricks/
sudo rm -rf .cargo/
sudo rm -rf ./.multirust/
sudo -i
git clone https://github.com/netsys/netbricks
cd netbricks/
export RUST_STATIC=1
htop
./build.sh 
htop
rm -rf netbricks/
curl https://sh.rustup.rs -sSf | sh
source $HOME/.cargo/env
rustup install nightly
rustup override set nightly
git clone https://github.com/netsys/netbricks
cd netbricks/
rustup override set nightly
./build.sh 
./build.sh run
./build.sh run zcsi-test
./build.sh run zcsi-test -h
htop
ls
cd netbricks/
ls
./build.sh run zcsi-test -h
./build.sh run zcsi-test -p 0
./build.sh run zcsi-test -p 0 -c 2
./build.sh run zcsi-test  -c 2
./build.sh run zcsi-test -h
../dpdk/tools/dpdk-devbind.py -s
./build.sh run zcsi-test -p dpdk:0000:04:00.0
./build.sh run zcsi-test -p dpdk:wurst
sudo ./build.sh run zcsi-test -p dpdk:wurst
less /proc/meminfo 
sudo -i
less /proc/meminfo 
sudo ./build.sh run zcsi-test -p dpdk:wurst
sudo ./build.sh run
sudo ./build.sh run zcsi-config
sudo ./build.sh run zcsi-config -h
sudo ./build.sh run zcsi-reset -h
sudo ./build.sh run zcsi-reset
sudo ./build.sh run zcsi-tcp -h
less /proc/meminfo 
sudo ./build.sh run zcsi-lpm -h
sudo ./build.sh run zcsi-lpm -p asdf_sdf
sudo apt-get install libgnutls30 libgnutls-openssl-dev libcurl4-gnutls-dev
lsb_release -a
uname -a
w
htop
w
ls
cd netbricks/
ls
history
./build.sh run
../dpdk/tools/dpdk-devbind.py -s
./build.sh run zcsi-test -p dpdk:0000:04:00.0
./build.sh run zcsi-test -p 0000:04:00.0
su
sudo su
w
sudo pqos -r
htop
sudo pqos -r
htop
sudo pqos -r
pqos -e llc:1=0x00001
sudo pqos -e llc:1=0x00001
sudo pqos -a llc:1=0-3
sudo qpos -r
sudo pqos -r
htop
sudo pqos -s
sudo pqos -a llc:1=0-5
sudo pqos -r
sudo pqos 
sudo pqos -h
sudo pqos -v
sudo pqos -V
clean
clear
sudo pqos -v
sudo pqos -V
ls
./table-gen.sh 
./table-gen.sh 16000 1
ls
./table-gen.sh 16000 1 > rule_ipv4-40G.db
sudo mv rule_ipv4-40G.db /root/
sudo pqos -r
sudo su
w
sudo -i
ls
sudo -i
clear
sudo adduser tmeyer
sudo -i
history | grep adduser
cat .ssh/authorized_keys 
sudo -i
ifconfig 
sudo ./build-linux-kernel-test.sh 
ifconfig 
route
sudo -i
sudo chown schramm:schramm linux.cap 
sudo -o
sudo -i
sudo chown schramm:schramm linux.cap 
sudo -i
arp -l
arp -vn
w
last
ifconfig 
arp -vn -i enp4s0f1
route
arp
arp -vn -i enp4s0f1
arp -vn -i enp4s0f0
ping omanyte
arp
sudo -i
w
ifconfig 
ifconfig -a
sudo -o
sudo -i
../dpdk/tools/dpdk-devbind.py -s
./dpdk/tools/dpdk-devbind.py -s
nano build-linux-kernel-test.sh 
sudo nano build-linux-kernel-test.sh 
last
./dpdk/tools/dpdk-devbind.py -s
ifconfig 
route
arp
sudo -i
w
sudo -i
htop
w
sudo -i
w
sudo -i
w
sudo -i
w
sudo -i
w
last
w
sudo init 6
ls
w
sudo -i
ls
sudo -i
w
sudo -i
whoami
sudo -s
sudo -i
w
sudo -i
cd linpack_11.2.0/benchmarks/linpack/
./runme_xeon64
ls
screen -AmdS linpack
screen -r
htop
screen -r
sudo -i
w
last
vvvvvvvvvvvvvv
bg
bc
sudo -i
htop
kill 1218
sudo -i
w
sudo -i
htop
sudo -i
nano build-linux-kernel-test.sh 
ls
naano build-hybrid-linux-kernel-test.sh 
nano hybrid-linux-routing-table-gen.sh 
nano linux-routing-table-gen.sh 
nano build-hybrid-linux-kernel-test.sh 
ifconfig 
ping 10.0.0.2
route 10.0.0.2
route -v | less
tcpdump -i tap_dpdk_02
sudo tcpdump -i tap_dpdk_02
route -n | less
sudo -i
ls
sudo -i
scp kaunas:main.c ./
sudo -i
w
sudo -i
nano linux-routing-table-gen.sh 
sudo -i
sudo ./unbind-linux-routing.sh 
route
sudo -i
sudo ./unbind-linux-routing.sh 
sudo -i
w
sudo -i
java
sudo -i
whereis screen
htop
w
htop
cat .ssh/config
w
last
sudo -i
htop
w
sudo -i
w
last
htop
nano /home/schramm/build-linux-kernel-test2.sh
pqos -r
pqos -s
sudo pqos -s
w
last
w
last
cat disable-turbo-offloading.sh 
cat stress.sh 
sudo apt search pfsend
w
last
htop
w
sudo -i
uname -a
sudo -i
w
watch w
last
htop
w
htop
iftop 
sudo -i
w
htop
w
htop
ifconfig 
w
htop
w
htop
sudo htop
likwid
sudo -i
sudo -i
iostat -m 2
uname -a
ovs-vsctl show
sudo -i
w
last
sudo -i
htop
w
w
sudo -i
w
htop
ifconfig 
arp 
bmon
sudo /home/schramm/disable-turbo-offloading.sh
sudo -i
nano interrupts.txt 
ifconfig 
cat /proc/interrupts 
cat /proc/interrupts > interrupts.txt
nano interrupts.txt 
ls
sudo -i
w
sudo ./unbind-linux-routing.sh 
w
w
last
cat /proc/interrupts 
cat /proc/interrupts > interrupts.txt 
w
sudo -i
bmon
cat /proc/interrupts > interrupts.txt
w
cat stress.sh 
less stress.sh 
nano stress.sh 
stress-ng --taskset $CORES --cache 90 --cache-flush --cache-prefetch --aggressive --cpu 2 --cpu-method matrixprod -t 20 --metrics-brief
stress-ng --taskset 0-9,11-29,31-39 --cache 90 --cache-flush --cache-prefetch --aggressive --cpu 2 --cpu-method matrixprod -t 20 --metrics-brief
stress-ng --taskset 0-9,11-29,31-39 --cache 90 --cache-flush --cache-prefetch --aggressive --cpu 2 --cpu-method matrixprod -t 20 --metrics-brief --times --perf
sudo stress-ng --taskset 0-9,11-29,31-39 --cache 90 --cache-flush --cache-prefetch --aggressive --cpu 2 --cpu-method matrixprod -t 20 --metrics-brief --times --perf
sudo stress-ng --taskset 0-9,11-29,31-39 --cache 90 --cache-flush --cache-prefetch --aggressive --cpu 2 --cpu-method matrixprod -t 20 --metrics-brief --times --tz
sudo stress-ng --taskset 0-9,11-29,31-39 --cache 90 --cache-flush --cache-prefetch --aggressive --cpu 2 --cpu-method matrixprod -t 20 --metrics-brief --times -v
nano disable-turbo-offloading.sh 
stress-ng --help
ls
mkdir old-stuff
mv build-hybrid-linux-kernel-test.sh old-stuff/
mv build-linux-kernel-test.sh old-stuff/
mv build-linux-kernel-test3.sh old-stuff/
mv hybrid-linux-routing-table-gen.sh old-stuff/
mv iptables-gen.sh old-stuff/
mv likwid_4.1.2-1_amd64.deb old-stuff/
mv linux-routing-table-gen.sh old-stuff/
mv linpack_11.2.0/ old-stuff/
mv linux-routing-table-gen3.sh old-stuff/
cat nb-rt.txt 
ls
cat onp_cat.cfg 
cat out.txt 
rm out.txt 
sudo -i
w
ifx
ifconfig 
route -n | wc -l
watch "route -n | wc -l"
bmon
lsb_release 
lsb_release -a
sudo apt-get install lsb-release
apt-get install figlet
sudo apt-get install figlet
sudo apt-get install update-motd
sudo nano /etc/update-motd.d/00-header 
cat /etc/update-motd.d/00
cat /etc/update-motd.d/00-header 
sudo nano /etc/update-motd.d/20-information
cat /etc/update-motd.d/00-header 
sudo nano /etc/update-motd.d/00-header 
sudo -i
last
cat /proc/cpuinfo 
sudo -i
htop
sudo /etc/init.d/openvswitch-switch stop
route
sudo -i
uname -a
sudo -i
nano 00-header-mod 
sudo nano 00-header-mod 
sudo -i
cat disable-turbo-offloading.sh 
ethtool -g ens5f0
cat /etc/default/grub.d/
cat /etc/default/grub
htop
sudo -i
htop
last
w
sudo init 6
bmon
ls results_likwid/
rm results_likwid/likwid-run.txt 
sudo -i
lscpu
cat disable-turbo-offloading.sh 
cat /sys/devices/system/cpu/intel_pstate/no_turbo
lscpu
ls
cd linpack_11.2.0/benchmarks/linpack/
cd
last
bmon
lsb_release -a
uname -a
ls
cat linux-routing-table-gen2.sh 
route | less
ifconfig 
cat /etc/default/grub
ls dpdk/examples/
sudo -i
last
route
ifconfig 
watch route -n | wc -l
watch "route -n | wc -l"
arp
bmon
sudo -i
cat disable-turbo-offloading.sh 
sudo -i
w
last
w
last
w
htop
w
last
udo init sudo -i
sudo -i
w
last
sudo -i
sudo pqos -r
likwid-bench
w
sudo -i
w
sudo init 6
w
sudo -i
sudo dmesg
sudo dmesg | grep Cache
sudo dmesg | grep routing
sudo -i
w
last
w
sudo init 6
w
route
sudo -i
cd linpack_11.2.0/benchmarks/linpack/
./runme_xeon64
last | less
sudo -i
iostat -m 2
htop
w
w
lscpu
last
mtr 131.159.200.246
w
mount -t tmpfs /mnt/test1 /mnt/test1
sudo -i
cd bandwidth-1.3.1/
./bandwidth64 -n -2
./bandwidth64 -n 2
mtr zsmith.co
w
ifconfig 
w
ifconfig 
sudo -i
w
sudo -i
ls
w
last
sudo -o
sudo -i
w
sudo -i
htop
sudo -i
sudo pqos -r
modprobe msr
sudo modprobe msr
sudo pqos -r
cd bandwidth-1.3.1/
./bandwidth64 
nano parallel.sh
sudo -i
cd bandwidth-1.3.1/
w
sudo init 6
htop
w
watch -n 10 w
w
last
sudo -o
sudo -i
last
sudo -i
w
last
sudo -i
w
last
sudo init 6
sudo -i
htop
sudo pqos -r
sudo -o
sudo -i
w
htop
ifconfig 
sudo ethtool -l enxa0cec800a182
sudo -i
lscpu
sudo -i
w
last
sudo -i
htop
ls
sudo -i
sudo dmesg | grep routing
sudo dmesg | grep cache
sudo -i
