#!/bin/bash
LANG=en_US.utf8

#variables
date=$(date -d "$mon 1 $year" "+%Y-%m-%d")

mainip=$(hostname -i | tr -s " " | cut -f1 -d " ")

queue=$(exim -bpc)

ipsaida_atual=$(cat /etc/exim.conf | grep 'interface' | egrep -o "(((1[0-9]|[1-9]?)[0-9]|2([0-4][0-9]|5[0-5]))\.){3}((1[0-9]|[1-9]?)[0-9]|2([0-4][0-9]|5[0-5]))" | head -n 1)

ipsaida_listado=$(cat /var/log/exim_mainlog | grep "$date" | grep -m 1 "n550-csi.cloudmark.com/reset-request/?ip=$ipsaida_atual" | awk -F'/?ip=' '{print $2}' | cut -d"=" -f2 | awk '{print $1}')

cloudmarktrap=$(cat /var/log/exim_mainlog | grep "$date" | grep -m 1 "n550-csi.cloudmark.com/reset-request/?ip=$ipsaida_atual")
#variables

if [[ "$cloudmarktrap" == "" ]]; then

    exit

elif [[ "$ipsaida_atual" != "$ipsaida_listado" ]]; then

    exit

elif [[ "$ipsaida_listado" == "$ipsaida_atual" ]]; then

    echo -e "$cloudmarktrap\n\nMail queue: $queue" | mail -s "HostDime Brasil :: Servidor $HOSTNAME de IP $mainip listado na Cloud Mark"       abuse@hostdime.com.br

else

    exit

fi
