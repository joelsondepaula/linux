#!/bin/bash

# Caminho do arquivo de configuração do CSF
CSF_CONF="/etc/csf/csf.conf"
CSF_ALLOW="/etc/csf/csf.allow"

# Adicionando as portas 5001 e 5003 em TCP_IN
sed -i '/^TCP_IN/ s/"$/\,5001,5003"/' $CSF_CONF

# Adicionando as portas 5001 e 5003 em TCP_OUT
sed -i '/^TCP_OUT/ s/"$/\,5001,5003"/' $CSF_CONF

# Alterando DOCKER = "0" para DOCKER = "1"
sed -i '/^DOCKER = "0"/ s/"0"/"1"/' $CSF_CONF

# Liberando o IP 172.18.0.2
echo "172.18.0.2" >> $CSF_ALLOW

# Reiniciando o CSF para aplicar as mudanças
csf -r

# Exibindo a mensagem de conclusão
echo -e "As configurações foram atualizadas, o IP 172.18.0.2 foi liberado e o CSF foi reiniciado.\n"

echo "Necessário liberar o IP 172.18.0.2 no pg_hba.conf" 
