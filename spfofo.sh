#!/bin/bash

#by: higorV

# Solicitar o IP ao usuário
read -p "Digite o IP que deseja adicionar ao SPF (formato xxx.xxx.xxx.xxx): " USER_IP

# Validar o formato do IP (somente o endereço IPv4)
if [[ ! $USER_IP =~ ^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
    echo "Formato inválido. Certifique-se de usar o formato 'xxx.xxx.xxx.xxx'."
    exit 1
fi

# Adicionar o prefixo 'ip4:' ao IP fornecido
NEW_IP="ip4:$USER_IP"

# Diretório onde estão as zonas DNS
ZONES_DIR="/var/named"

# Arquivo de log
LOG_FILE="/var/log/spf_update.log"

# Função para registrar logs
log_message() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $1" >> "$LOG_FILE"
}

# Percorrer todos os arquivos de zona
for ZONE_FILE in $ZONES_DIR/*.db; do
    # Verificar se o arquivo contém um registro SPF
    if grep -q "v=spf1" "$ZONE_FILE"; then
        # Verificar se o IP já está no registro SPF
        if ! grep -q "$NEW_IP" "$ZONE_FILE"; then
            # Fazer backup do arquivo de zona
            cp "$ZONE_FILE" "$ZONE_FILE.bak"

            # Adicionar o novo IP ao registro SPF
            sed -i "/v=spf1/s/~all/$NEW_IP ~all/" "$ZONE_FILE"

            # Exibir e registrar qual arquivo foi modificado
            log_message "Adicionado $NEW_IP ao SPF de $(basename $ZONE_FILE)"
        else
            log_message "O IP $NEW_IP já está presente no SPF de $(basename $ZONE_FILE)"
        fi
    else
        log_message "Nenhum registro SPF encontrado em $(basename $ZONE_FILE)"
    fi
done
