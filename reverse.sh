#!/bin/bash

#touch reverseDNA.txt

FILE='reverseDNA.txt'

for i in `cat $FILE`; do echo -e "\nhttps://admin.dimenoc.com/network/ip/view/v4/$i\n"; done

