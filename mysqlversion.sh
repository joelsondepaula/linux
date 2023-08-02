#!/bin/bash

# Variável para validar as versões disponíveis
available="5.7,8.0,10.3,10.5,10.6"

echo "Versões disponíveis: $available"
read -p "Informe a versão do MySQL: " version

# Itera sobre os números usando um loop for e separando por ","
IFS=',' read -ra numbers_array <<< "$available"

# Variável para verificar se a versão do MySQL é válida de acordo com a variável "available"
valid_version=0

for number in "${numbers_array[@]}"; do
    if [[ $version == $number ]]; then
        valid_version=1
        break
    fi
done

if [[ $valid_version -eq 0 ]]; then
    echo "A versão do MySQL é inválida: $version"
    echo "Versões disponíveis: $available"
else
    # Criação do diretório e arquivo de configuração para setar versão do MySQL
    dir="/root/cpanel_profile"
    file="/root/cpanel_profile/cpanel.config"
    mkdir -p "$dir"
    echo "mysql-version=$version" > "$file" && cat /root/cpanel_profile/cpanel.config
fi
