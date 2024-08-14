#!/bin/bash 
# ============================ 
# Data Science Academy 
# Script: script4.sh 
# ============================= 
# Array 
SERVERLIST=("server01" "server02" "server03" "server04") 
COUNT=0 

# Loop 
for INDEX in ${SERVERLIST[@]}; do 
echo "Server: ${SERVERLIST[COUNT]}" 
COUNT="`expr $COUNT + 1`" 
done
