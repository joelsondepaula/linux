#!/bin/bash

# Altere o listen_addresses para '*'
sed -i "s/^listen_addresses = 'localhost'/listen_addresses = '*'/" /opt/e-SUS/database/postgresql-9.6.13-1-linux-x64/data/postgresql.conf

# Adicione as linhas no final do pg_hba.conf
sed -i -e "\$a host    all             all             186.235.48.109/32       md5" -e "\$a host    all             all             10.100.42.0/25          md5" /opt/e-SUS/database/postgresql-9.6.13-1-linux-x64/data/pg_hba.conf

# Reinicie o serviço do PostgreSQL
systemctl restart e-SUS-AB-PostgreSQL.service

# Confirme a conclusão
echo "Configurações atualizadas e serviço reiniciado com sucesso."
