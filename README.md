# Master Thesis Benchmarking Suite

This repository contains a collection of shell scripts and Lua modules developed for performance benchmarking research in a master thesis. The suite focuses on network packet processing performance under various hardware and software configurations.

## Overview

The project is organized into two main components that work together in a distributed testing setup:

- **omanyte moongen**: Traffic generation and load testing scripts running on a load generator host
- **omastar dut**: Configuration and monitoring scripts for the Device Under Test (DUT)

The testing infrastructure uses SSH for remote command execution, allowing automated benchmarking scenarios to be executed from a central controller.

## Architecture

The benchmarking system consists of two physical hosts:

**Load Generator (omanyte)**
- Runs MoonGen, a high-performance packet generator written in Lua
- Executes benchmark scripts that control traffic generation parameters
- Collects performance metrics and latency data
- Communicates with the DUT via SSH to coordinate test execution

**Device Under Test (omastar)**
- Target system for performance evaluation
- Hosts network forwarding applications (Linux kernel, DPDK, Netbricks)
- Runs CPU stress generation and performance monitoring tools
- Receives configuration commands from the load generator via SSH

## Components

### omanyte moongen

Contains scripts for traffic generation and orchestration:

**Main Benchmark Script**
- `mg-bench.sh`: Primary benchmarking tool that controls MoonGen execution, defines traffic parameters (flow count, packet size, transmission rate), and collects results with LIKWID performance counters

**Test Orchestration Scripts**
- `masterscript-linux.sh`: Benchmarks the Linux kernel network stack with varying cache allocation policies
- `masterscript-dpdk.sh`: Tests DPDK-based packet processing with Intel RDT cache partitioning
- `masterscript-netbricks.sh`: Evaluates Netbricks, a modular network function framework
- `masterscript-cachesize-*.sh`: Systematic cache size variation studies for DPDK and Linux configurations
- `masterscript-L7-L8-D7-D8.sh`: Tests specific processor cache levels and configurations
- `masterscript-linux-100k.sh`: Large-scale flow count scenarios
- `megamaster.sh`: Meta-orchestration script that manages overall test execution and timing

**MoonGen Lua Module**
- `l3-load-latency.lua`: MoonGen traffic generation script that creates UDP flows with configurable rates, source IP randomization, flow counts, and packet sizes. Includes latency measurement capabilities through packet timestamping.

### omastar dut

Configuration and monitoring utilities for the test system:

**System Configuration**
- `disable-turbo-offloading.sh`: Disables CPU turbo boost and network interface offloading to ensure consistent performance characteristics
- `gov.sh`: Manages CPU frequency scaling governor settings
- `build-linux-kernel-test2.sh`: Rebuilds and loads the Linux forwarding kernel module

**Load and Stress Generation**
- `stress.sh`: Generates CPU load using stress-ng with configurable core masks and duration. Supports three modes: Linux kernel testing, DPDK testing, and benchmark-specific configurations

**Routing Configuration**
- `dpdk-table-gen.sh`: Generates routing tables for DPDK l3fwd-acl application
- `linux-routing-table-gen2.sh`: Generates Linux kernel routing tables
- `netbricks-routing-table-gen.sh`: Generates routing configurations for Netbricks
- `acl-gen.sh`: Generates ACL rules for packet filtering

**Monitoring and System Configuration**
- `likwid.sh`: Wrapper for LIKWID performance monitoring tool
- `unbind-linux-routing.sh`: Manages network driver binding/unbinding for mode switching
- `00-header-mod` / `00-header-org`: MOTD headers for system identification

## Test Methodology

The benchmarking workflow follows this pattern:

1. **Preparation**: The load generator connects to the DUT via SSH and executes configuration scripts to set the desired system state (cache allocation, CPU frequency, network driver binding)

2. **Stress Generation**: CPU stress processes are started on the DUT to simulate realistic workload conditions

3. **Traffic Generation**: MoonGen on the load generator transmits UDP packets with specific characteristics:
   - Variable flow counts (1 to 500,000 concurrent flows)
   - Packet sizes typically 64 bytes
   - Transmission rates from 100 Mbps to 7000 Mbps
   - Latency measurements via hardware timestamping

4. **Monitoring**: LIKWID collects hardware performance counters (cache misses, IPC, memory bandwidth) during the test

5. **Data Collection**: Results are stored with timestamps, including latency histograms and performance metrics

6. **System Reset**: Configuration is reverted and resources are cleaned up

## Configuration Requirements

Before running these scripts, the following prerequisites must be met:

**SSH Setup**
- SSH key-based authentication configured for passwordless root access to the DUT host (omastar)
- SSH key must be installed in `/root/.ssh/authorized_keys` on the DUT

**Hardware Requirements**
- Multi-core processor (40+ cores for realistic load distribution)
- 10Gbps or 40Gbps network interfaces on both hosts
- Intel processor with RDT (Resource Director Technology) for cache allocation tests
- Support for hardware timestamping in network interface cards

**Software Requirements**
- MoonGen installed at `/home/schramm/MoonGen` on load generator
- DPDK and l3fwd-acl compiled at `/root/dpdk/examples/l3fwd-acl/` on DUT
- Linux kernel with forwarding module support
- stress-ng for load generation
- LIKWID for performance monitoring
- Intel pqos utility for cache allocation control

**Script Variables**
- Modify `MG_PATH` in mg-bench.sh to point to MoonGen installation
- Adjust `OUT` and `IN` port numbers to match your network setup
- Update server hostnames (currently hardcoded as `omastar` and `omanyte`)

## Usage

To run a complete benchmark suite:

```bash
cd omanyte\ moongen/
./masterscript-linux.sh
```

This will execute all Linux kernel benchmarks with varying cache configurations and produce timestamped result directories.

To run a single benchmark with custom parameters:

```bash
./mg-bench.sh -f 50000 -n test-50k-flows -r 100 1000 100 -c linux -s 64
```

Parameters:
- `-f`: Number of flows
- `-n`: Result directory name
- `-r`: Rate range (min max step in Mbps)
- `-c`: Core mask type (linux/dpdk)
- `-s`: Packet size in bytes

## Output

Results are stored in timestamped directories containing:
- Latency histograms from packet measurements
- LIKWID performance counter data
- MoonGen statistics (packets sent, dropped, latency min/max/avg)
- Test configuration logs

## Notes

These scripts are tailored to a specific research environment and hardware setup. Direct usage on other systems will require significant adaptation of hardcoded paths, server names, network configuration, and hardware-specific settings.

The test duration can be substantial, particularly for the cache size variation studies which test multiple cache allocation scenarios and flow counts.
