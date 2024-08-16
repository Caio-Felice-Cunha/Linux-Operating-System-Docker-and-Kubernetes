#!/bin/bash
# ==============================
# Data Science Academy
# Script: script7.sh
# ==============================
clear
echo "Disk Space Usage Report on machine: $HOSTNAME"
echo ""
echo "All mount points:"
echo ""
df -TH
echo ""
echo "Checking these mount points:"
echo ""
df -H | grep -vE '^Filesystem|tmpfs|cdrom'
echo ""
echo "Simplifying the data:"
echo ""
df -H | grep -vE '^Filesystem|tmpfs|cdrom' | awk '{ print $5 " " $1 }'
echo ""
echo "Loop through the found items to check the available space:"
echo ""

# Loop
df -H | grep -vE '^Filesystem|tmpfs|cdrom' | awk '{ print $5 " " $1 }' | while read output;
do
echo $output
space_used=$(echo $output | awk '{ print $1}' | cut -d'%' -f1 )
partition=$(echo $output | awk '{ print $2 }' )
if [ $space_used -ge 80 ]; then
echo "Running out of space on disk \"$partition ($space_used%)\" on $(hostname) as on $(date)"
fi
done