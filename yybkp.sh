#!/bin/bash

cd /home/.hd

wget -q --no-check-certificate https://codesilo.dimenoc.com/joelson.p/scripts/-/raw/main/spamdorabox.txt

spambase=$(cat spamdorabox.txt)

grep "A=dovecot_.*:" /var/log/exim_mainlog | grep -iE "$spambase"

rm -f spamdorabox.txt
