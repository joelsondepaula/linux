#!/bin/bash

echo "Please select a timezone:"
echo
echo "1) America/Argentina/Buenos_Aires"
echo "2) America/Fortaleza"
echo "3) America/New_York"
echo "4) America/Porto_Acre"
echo "5) America/Sao_Paulo"
echo "6) America/Toronto"
echo
read -p "Select option 1-6: " option

case $option in
    1) sudo timedatectl set-timezone America/Argentina/Buenos_Aires
    ;;
    2) sudo timedatectl set-timezone America/Fortaleza
    ;;
    3) sudo timedatectl set-timezone America/New_York
    ;;
    4) sudo timedatectl set-timezone America/Porto_Acre
    ;;
    5) sudo timedatectl set-timezone America/Sao_Paulo
    ;;
    6) sudo timedatectl set-timezone America/Toronto
    ;;
    *) echo "Invalid option selected"
    ;;
esac
