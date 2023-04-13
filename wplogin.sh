#!/bin/bash

LANG=en_us_8859_1

date=$(date +"%a %b %d")

cat /var/log/apache2/error_log | grep ModSecurity | grep "wp-login.php" | awk -F'hostname' '{print $2}' | cut -d'"' -f2 | sort | uniq -c | sort -rn
