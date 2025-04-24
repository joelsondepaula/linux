#!/bin/bash

# Caminho do arquivo de configuração do CSF
CSF_CONF="/etc/csf/csf.conf"

# Adicionando as portas 5001 e 5003 em TCP_IN
sed -i '/^TCP_IN/ s/"$/\,5001,5003"/' $CSF_CONF

# Adicionando as portas 5001 e 5003 em TCP_OUT
sed -i '/^TCP_OUT/ s/"$/\,5001,5003"/' $CSF_CONF

# Alterando DOCKER = "0" para DOCKER = "1"
sed -i '/^DOCKER = "0"/ s/"0"/"1"/' $CSF_CONF

# Reiniciando o CSF para aplicar as mudanças
csf -r

# Exibindo a mensagem de conclusão
echo "As configurações foram atualizadas e o CSF foi reiniciado."
