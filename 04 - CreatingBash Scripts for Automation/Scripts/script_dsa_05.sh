#!/bin/bash
# ==============================
# Data Science Academy
# Script: script5.sh
# ==============================
# Case
clear
echo "MENU"
echo "========="
echo "1 FCD"
echo "2 FADA"
echo "3 FED"
echo "4 FAD"
echo "5 FEM"
echo "6 FEI"
echo "7 FEB"
echo "8 FRPA"
echo "9 FLP"
echo "10 FML"
echo "11 FAE"
echo "12 FIAV"
echo "13 FSIB"
echo "S Exit"
echo "Enter the number of the course you are taking in DSA (or S to exit and end the script): "
read MENUCHOICE
case $MENUCHOICE in
1)
 echo "You chose the Data Scientist course. Congratulations!";;
2)
 echo "You chose the Data Analyst course. Congratulations!";;
3)
 echo "You chose the Data Engineer course. Congratulations!";;
4)
 echo "You chose the Data Architect course. Congratulations!";;
5)
 echo "You chose the Machine Learning Engineer course. Congratulations!";;
6)
 echo "You chose the AI ​​Engineer course. Congratulations!";;
7)
 echo "You chose the Blockchain Engineer course. Congratulations!";;
8)
 echo "You chose the RPA Developer course. Congratulations!";;
9)
 echo "You chose the Python Language for Data Science course. Congratulations!";;
10)
 echo "You chose the Machine Learning Training. Congratulations!";;
11)
 echo "You chose the Statistical Analysis Training. Congratulations!";;
12)
 echo "You chose the Artificial Intelligence for Sales Training. Congratulations!";;
13)
 echo "Congratulations!";;
S)
 echo "You asked to end the script!";;
esac
