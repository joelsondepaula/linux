#!/bin/bash

# Coleta a versão do banco de dados
pg_version=$(cat /opt/e-SUS/database/current/data/PG_VERSION)

# Coleta a versão do e-SUS PEC
esus_version=$(grep "backend-" /var/log/syslog | awk -F'backend-' '{print $2}' | awk -F'.jar' '{print $1}' | tail -n 1)

# Gera a saída no formato JSON
echo "{\"pg_version\": \"$pg_version\", \"esus_version\": \"$esus_version\"}"
