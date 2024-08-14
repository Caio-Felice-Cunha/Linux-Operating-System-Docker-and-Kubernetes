#!/bin/bash
# ==============================
# Data Science Academy
# Script: script9.sh
# ==============================
# Auditoria de Segurança

# Warning: Run the command below in bash before running this script:

# apt install net-tools

clear
echo "###############################################"
echo "###############################################"
echo "Linux Security Audit Report."
echo "###############################################"
echo "###############################################"
echo "Let's start the audit in 3 seconds..."
sleep 3
echo
echo "This is the name of the machine: $HOSTNAME"
echo
echo "Starting the audit..."
START=$(date +%s)
echo
echo -e "\e[0;33m1. Linux Kernel Details\e[0m"
uname -a
echo
echo -e "\e[0;33m2. Version of this Linux Distribution\e[0m"
cat /etc/os-release | grep -e VERSION=
echo
echo -e "\e[0;33m3. Searching for files with permission 777\e[0m"
find / -type f -perm 0777;
echo
echo -e "\e[0;33m4. Active Connections and Open Ports\e[0m"
netstat -natp
echo
echo -e "\e[0;33m5. History of Executed Commands\e[0m"
history
echo
echo -e "\e[0;33m6. Network Interfaces\e[0m"
ifconfig -a
echo
echo -e "\e[0;33m7. List of all installed packages\e[0m"
apt-cache pkgnames
echo
echo -e "\e[0;33m8. Network Parameters\e[0m"
cat /etc/sysctl.conf
echo
echo -e "\e[0;33m9. Password Policies\e[0m"
cat /etc/pam.d/common-password
echo
echo -e "\e[0;33m10. Source List\e[0m"
cat /etc/apt/sources.list
echo
echo -e "\e[0;33m11. Checking for Broken Dependencies\e[0m"
apt-get check
echo
echo -e "\e[0;33m12. Listing packages that can be upgraded\e[0m"
apt list --upgradeable
echo
echo -e "\e[0;33m13. Users with access to the OS\e[0m"
cut -d: -f1 /etc/passwd
echo
echo -e "\e[0;33m14. Checking Null Passwords\e[0m"
users="$(cut -d: -f 1 /etc/passwd)"
for x in $users
do
passwd -S $x |grep "NP"
done
echo
echo -e "\e[0;33m15. CPU and System Information\e[0m"
cat /proc/cpuinfo
echo
END=$(date +%s)
DIFF=$(( $END - $START ))
echo Audit completed in $DIFF seconds!
echo
echo Report generation date:
date
echo
echo Congratulations on learning Linux here at Data Science Academy!
echo

