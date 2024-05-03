#!/bin/bash

# Objective:
#   Write a standalone script that checks if the current system meets the following minimum requirements:
#   Ubuntu 20.04 LTS ("Focal Fossa"): later versions are not supported yet
#   8 vCPUs: a CPU with AVX support is required
#   16 GB RAM
#   32 GB Free Disk Space

# Task:
#   Implement your solution in a common scripting language that is pre-installed on Ubuntu 20 (Bash or Python solutions are preferred)
#   Feel free to use rounded values (e.g. 15.8 GB RAM is good enough)
#   Check each requirement and output the current value on the system and the required value. Please format the output to be easily
#   readable!
#   Print a final verdict at the end: PASSED or FAILED (if we had at least one missing requirement)

# Check for Ubuntu 20.04 LTS
exho "Checnking if system meets minimum requirements"
echo " " 

echo "System requirements"
echo "Ubuntu version        20.04"
echo "vCPU cores            8"
echo "AVX support           YES"
echo "RAM                   16GB"
echo "Free Disk Space       32Gb" 

#declaring variables
ubuntu_version=$(lsb_release -rs)
cpu_cores=$(lscpu | awk '/^CPU\(s\):/{print $2}')
#avx 
# If AVX is not among the CPU flags in proc/cpuinfo it will result a 0
avx_support=$(grep -o avx /proc/cpuinfo | wc -l)
avx_support_text='YES'
if (( $(grep -o avx /proc/cpuinfo | wc -l) == 0 )); then
    avx_support_text='NO'
fi
echo $avx_support_text
#RAM 
#The total RAM result is in MB, so we need to convert it to GB 
total_ram=$(free -m | awk '/^Mem:/{print $2/1024}')
echo $total_ram | awk '{print int($1+0.5)}'
free_disk_space=$(df -BM --output=avail / | sed '1d;s/[^0-9]*//g')

echo "System specification"
echo "Ubuntu version        $ubuntu_version"
echo "vCPU cores            $cpu_cores"
echo "AVX support           $avx_support"
echo "RAM                   $total_ram"
echo "Free Disk Space       $free_disk_space" 

ubuntu_version=$(lsb_release -rs)
ubuntu_passed="YES"
if [[ "$ubuntu_version" != "20.04" ]]; then
    ubuntu_passed="NO"
fi

echo $ubuntu_version
echo $ubuntu_passed



echo "                  Requirements    System specification    Passed"
echo "Ubuntu version    20.04           $ubuntu_version         $ubuntu_passed"

ubuntu_version=$(lsb_release -rs)
echo $ubuntu_version
if [[ "$ubuntu_version" != "20.04" ]]; then
    echo "Error: This script requires Ubuntu 20.04 LTS ('Focal Fossa')."
fi

# Check for CPU cores and AVX support
cpu_cores=$(lscpu | awk '/^CPU\(s\):/{print $2}')
echo $cpu_cores
avx_support=$(grep -o avx /proc/cpuinfo | wc -l)
echo $avx_support
if (( cpu_cores < 8 || avx_support == 0 )); then
    echo "Error: This script requires at least 8 vCPUs with AVX support."
fi

# Check for RAM
total_ram=$(free -m | awk '/^Mem:/{print $2}')
echo $total_ram
if (( total_ram < 16000 )); then
    echo "Error: This script requires at least 16 GB of RAM."
fi

# Check for Free Disk Space
free_disk_space=$(df -BM --output=avail / | sed '1d;s/[^0-9]*//g')
echo $free_disk_space
if (( free_disk_space < 32000 )); then
    echo "Error: This script requires at least 32 GB of free disk space."
fi

echo "System requirements are met. You're good to go!"
exit 0
