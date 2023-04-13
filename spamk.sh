#!/bin/bash

LANG=en_US.utf8
date=$(date -d "$mon 1 $year" "+%Y-%m-%d")
trigger10=500

rm -f retorno.txt
touch retorno.txt
archive='retorno.txt'
ipsaida=$(hostname -i | tr -s " " | cut -f1 -d " ")

echo -e "Logins used to send e-mail:" >> retorno.txt

cat /var/log/exim_mainlog | grep "$date" | grep "A=dovecot_.*:" | awk -F"A=" '{ print $2 }' | cut -f1 -d' ' | sort | uniq -c | sort -rn | head -20 >> retorno.txt

echo -e "Directories used to send e-mail:" >> retorno.txt

cat /var/log/exim_mainlog | grep "$date" | grep -hoP "(?<=cwd=)/[^ ]+" /var/log/exim_mainlog | sort | uniq -c | sort -nr | head -20 >> retorno.txt

sed -i '\/var\/spool\/exim/d' retorno.txt && sed -i '\/etc\/csf/d' retorno.txt && sed -i '\/root/d' retorno.txt

trigger1=$(cat retorno.txt | grep -A1 "Logins used to send e-mail:" | sed -n '/Logins used to send e-mail:/{n;p}' | awk '{ print $1 }')
trigger2=$(cat retorno.txt | grep -A1 "Directories used to send e-mail:" | sed -n '/Directories/{n;p}' | awk '{ print $1 }')

if [[ "$trigger1" -ge "$trigger10" ]]; then

                echo "$(cat $archive)" | mail -s "HostDime Brasil :: Possível envio de SPAM partindo do servidor $HOSTNAME de IP $ipsaida" hostdimecheck@hotmail.com
    else

                if [[ "$trigger2" -ge "$trigger10" ]]; then


                                echo "$(cat $archive)" | mail -s "HostDime Brasil :: Possível envio de SPAM partindo do servidor $HOSTNAME de IP $ipsaida" hostdimecheck@hotmail.com

                        else
                            	exit;
                fi
fi

## rm -f retorno.txt


