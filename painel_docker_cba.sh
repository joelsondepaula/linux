#!/bin/bash

# Caminho do arquivo de configuração do CSF
CSF_CONF="/etc/csf/csf.conf"
CSF_ALLOW="/etc/csf/csf.allow"

# Verificando se o Docker está instalado
if ! command -v docker &> /dev/null; then
    echo "Docker não encontrado. Instalando Docker..."

    # Atualizando os pacotes
    apt-get update

    # Instalando pacotes necessários
    apt-get install -y apt-transport-https ca-certificates curl software-properties-common

    # Adicionando chave GPG do Docker
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

    # Adicionando repositório do Docker
    sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

    # Atualizando novamente os pacotes
    apt-get update

    # Instalando o Docker
    apt-get install -y docker-ce

    # Verificando a instalação
    docker --version
else
    echo "Docker já está instalado."
fi


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
