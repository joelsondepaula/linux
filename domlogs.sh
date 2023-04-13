#!/bin/bash

LC_TIME=en_US.utf8

date=$(date -d "$mon 1 $year" "+%d/%b/%Y")

cpanelaccount=${1}
trigger=${2}
domain=$(grep $cpanelaccount /etc/trueuserdomains | awk -F':' '{print $1}')

egrep -i "$date" /var/log/apache2/domlogs/$cpanelaccount/$domain-ssl_log | grep "$trigger" | tr -s " " | cut -f2 -d " " | sort | uniq -c | sort -rn



##teste