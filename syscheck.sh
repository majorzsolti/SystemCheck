#!/bin/bash

# Check for Ubuntu 20.04 LTS
ubuntu_version=$(lsb_release -rs)
echo ubuntu_version
if [[ "$ubuntu_version" != "20.04" ]]; then
    echo "Error: This script requires Ubuntu 20.04 LTS ('Focal Fossa')."
    exit 1
fi

# Check for CPU cores and AVX support
cpu_cores=$(lscpu | awk '/^CPU\(s\):/{print $2}')
echo cpu_cores
avx_support=$(grep -o avx /proc/cpuinfo | wc -l)
echo avx_support
if (( cpu_cores < 8 || avx_support == 0 )); then
    echo "Error: This script requires at least 8 vCPUs with AVX support."
    exit 1
fi

# Check for RAM
total_ram=$(free -m | awk '/^Mem:/{print $2}')
echo total_ram
if (( total_ram < 16000 )); then
    echo "Error: This script requires at least 16 GB of RAM."
    exit 1
fi

# Check for Free Disk Space
free_disk_space=$(df -BM --output=avail / | sed '1d;s/[^0-9]*//g')
echo free_disk_space
if (( free_disk_space < 32000 )); then
    echo "Error: This script requires at least 32 GB of free disk space."
    exit 1
fi

echo "System requirements are met. You're good to go!"
exit 0
