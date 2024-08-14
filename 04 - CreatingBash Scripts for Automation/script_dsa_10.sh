#!/bin/bash
# ==============================
# Data Science Academy
# Script: script10.sh
# ==============================
# Backup of scripts (with versioning)

# Source
path_src=/mnt/dsacademy

# Destination
# mkdir /tmp/Backup
path_dst=/tmp/Backup

echo
echo -e "\e[0;33mStarting to Backup Lab 4 Scripts.\e[0m"

# Loop through source files
for file_src in $path_src/*; do

  cp -a -- "$file_src" "$path_dst/${file_src##*/}-$(date +"%d-%m-%y-%r")"

done

echo
echo -e "\e[0;33mBackup Complete. Checking folder /tmp/Backup .\e[0m"
cd /tmp/Backup
ls -la
cd /mnt/dsacademy
echo
echo -e "\e[0;33mThanks.\e[0m"
