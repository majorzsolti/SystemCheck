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
echo "RAM                   16 GB"
echo "Free Disk Space       32 Gb" 
echo " " 

#declaring main variables
ubuntu_version=$(lsb_release -rs)

cpu_cores=$(lscpu | awk '/^CPU\(s\):/{print $2}')

#avx 
# If AVX is not among the CPU flags in proc/cpuinfo it will result a 0
# AVX variable to be converted to readable text (Yes/no)
avx_support=$(grep -o avx /proc/cpuinfo | wc -l)
avx_support_text='YES'
if (( $(grep -o avx /proc/cpuinfo | wc -l) == 0 )); then
    avx_support_text='NO'
fi
# echo $avx_support_text

#RAM 
#The total RAM result is in MB, so we need to convert it to GB and also round it
total_ram=$(free -m | awk '/^Mem:/{printf "%.1f", $2/1024}')
# echo $total_ram

#free disk space
# free_disk_space=$(df -BM --output=avail / | sed '1d;s/[^0-9]*//g')
free_disk_space=$(df -BM --output=avail / | sed '1d;s/[^0-9]*//g' | awk '{printf "%.1f", $1/1024}')

echo "System specification"
echo "Ubuntu version        $ubuntu_version"
echo "vCPU cores            $cpu_cores"
echo "AVX support           $avx_support_text"
echo "RAM                   $total_ram GB"
echo "Free Disk Space       $free_disk_space GB" 

# Print out detailed results to the user
#main control variable
met_requirement='YES'
#Ubuntu version
if [[ "$ubuntu_version" != "20.04" ]]; then
    echo "Error: This script requires Ubuntu 20.04 LTS ('Focal Fossa')."
    met_requirement='NO'
fi

# CPU cores and AVX support
if (( cpu_cores < 8 || avx_support == 0 )); then
    echo "Error: This script requires at least 8 vCPUs with AVX support."
    met_requirement='NO'
fi

# RAM
total_ram=$(free -m | awk '/^Mem:/{print $2}')
echo $total_ram
if (( total_ram < 15.5 )); then
    echo "Error: This script requires at least 16 GB of RAM."
    met_requirement='NO'
fi

# Free Disk Space
free_disk_space=$(df -BM --output=avail / | sed '1d;s/[^0-9]*//g')
echo $free_disk_space
if (( free_disk_space < 31.5 )); then
    echo "Error: This script requires at least 32 GB of free disk space."
    met_requirement='NO'
fi

if (( met_requirement == 'NO' )); then
    echo "System requrements not met! Make sure to install sufficient hardware before using the product!"
    exit 1
else
    echo "System requirements are met. You're good to go!"
    exit 0
fi
