#!/bin/bash

domain=$1

account=$(grep "$domain" /etc/userdomains | awk '{print $2}')

grep "$account" /etc/trueuserowners

exit

