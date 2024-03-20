#!/bin/bash

for i in $(find /var/named -maxdepth 1 -type f -name "*.db" | awk -F"/var/named/" '{print $2}' | sed 's/\.db$//'); do
    ns_result=$(dig +short NS $i)

    # Verifica se ns1.domain ou ns2.domain estão presentes
    if [[ $ns_result != *ns1.ilumisol.com.br.* && $ns_result != *ns2.ilumisol.com.br.* ]]; then
        echo "========================"
    echo "$i"
        echo "$ns_result"
    echo "========================"
    fi
