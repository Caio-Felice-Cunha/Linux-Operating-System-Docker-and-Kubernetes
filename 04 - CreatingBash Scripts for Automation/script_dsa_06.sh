#!/bin/bash
# ==============================
# Data Science Academy
# Script: script6.sh
# ==============================

# Extract the current date from the system
# Use date --help to check the options
current_time=$(date +"%H%M%S")

# Create a backup of the folder using the current date in the file name
tar -czf dados_$horario_corrente.tar.gz /root/dados/ml-latest-small

# Move the file to another folder
mv dados_$horario_corrente.tar.gz /tmp