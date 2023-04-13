#!/bin/bash

port=$1

netstat -tulpan | grep ":$1" | awk {'print $5'} | cut -d: -f1 | sort | uniq -c | sort -n