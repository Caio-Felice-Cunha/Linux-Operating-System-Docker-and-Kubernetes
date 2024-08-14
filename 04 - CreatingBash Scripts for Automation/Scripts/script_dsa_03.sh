#!/bin/bash
# ==============================
# Data Science Academy
# Script: script3.sh
# ==============================
# User Input
echo "Enter your first name: "
read FIRSTNAME
echo "Enter your last name: "
read LASTNAME
echo ""
echo "Your full name: $FIRSTNAME $LASTNAME"
echo ""
echo "Enter your age now: "
read USERAGE
echo "In 10 years you will be `expr $USERAGE + 10` years old."
