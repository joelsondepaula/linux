#!/bin/bash

cd /home/.hd

wget -q --no-check-certificate https://codesilo.dimenoc.com/joelson.p/scripts/-/raw/main/spamdorabox.txt

spambase=$(cat spamdorabox.txt)

grep "A=dovecot_.*:" /var/log/exim_mainlog | grep -iE "$spambase" > /tmp/yy.txt

senders=$(cat /tmp/yy.txt | grep "<= " | awk -F"<= " '{print $2}' | cut -f1 -d' ' | sort | uniq -c | sort -rn)

getaccount=$(cat /tmp/yy.txt | grep "<= " | awk -F"<= " '{print $2}' | cut -f1 -d' ' | sort | uniq -c | awk '{print $2}')

getmessageid=$(cat /tmp/yy.txt | grep -m 1 "$getaccount" | awk '{print $3}')

examplemessage=$(cat /tmp/yy.txt | grep "$getmessageid")


echo "$senders"

echo "$examplemessage"


rm -f spamdorabox.txt


#grep "A=dovecot_.*:" /var/log/exim_mainlog | grep -iE "$spambase" > /tmp/yy.txt


#yytxt=$(cat /tmp/yy.txt)

#echo -e "$yytxt"

#senders=$(cat /tmp/yy.txt | grep "<= " | awk -F"<= " '{print $2}' | cut -f1 -d' ' | sort | uniq -c | sort -rn)
#titles=$(cat /tmp/yy.txt | grep "T=" | awk -F"T=" '{print $2}' | tr -s " " | grep -oP '(").*(")' | sort | uniq -c | sort -rn)

#echo -e "Remetentes:\n$senders"
#echo -e "Títulos:\n$titles"


