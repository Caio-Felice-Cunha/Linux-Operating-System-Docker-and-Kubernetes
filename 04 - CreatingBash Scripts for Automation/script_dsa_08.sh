#!/bin/bash
# ==============================
# Data Science Academy
# Script: script8.sh
# ==============================
# Script to show current system status
# Colors in Bash: https://tldp.org/HOWTO/Bash-Prompt-HOWTO/x329.html
clear
echo ""
echo -e "\e[31;43m***** Hostname *****\e[0m"
hostname
echo ""
echo -e "\e[31;43m***** Platform (32 or 64 Bits) *****\e[0m"
uname -i
echo ""
echo -e "\e[31;43m***** Linux Version *****\e[0m"
cat /etc/os-release | grep -e PRETTY_NAME -e VERSION=
echo ""
echo -e "\e[31;43m***** Disk Space Used *****\e[0m"
df -H | grep -vE '^tmpfs|cdrom'
echo ""
echo -e "\e[31;43m ***** RAM Usage *****\e[0m"
free
echo ""
echo -e "\e[31;43m***** System Uptime and Load *****\e[0m"
uptime
echo ""
echo -e "\e[31;43m***** Top 5 Processes by Memory Usage *****\e[0m"
ps -eo %mem,%cpu,comm --sort=-%mem | head -n 6
echo ""