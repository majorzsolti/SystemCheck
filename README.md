# Task 1 - Scripting test

## Objective:
Write a standalone script that checks if the current system meets the following minimum requirements:
Ubuntu 20.04 LTS ("Focal Fossa"): later versions are not supported yet
8 vCPUs: a CPU with AVX support is required
16 GB RAM
32 GB Free Disk Space

## Task:
Implement your solution in a common scripting language that is pre-installed on Ubuntu 20 (Bash or Python solutions are preferred)
Feel free to use rounded values (e.g. 15.8 GB RAM is good enough)
Check each requirement and output the current value on the system and the required value. Please format the output to be easily
readable!
Print a final verdict at the end: PASSED or FAILED (if we had at least one missing requirement)

## Solution 
The provided script will perform the following actions

- Print out the required system requirements
- Print out the current System Specifications 
- Print out detailed messages if we fail one or more checks
- Print out whether the system check result is PASSED or FAILED
