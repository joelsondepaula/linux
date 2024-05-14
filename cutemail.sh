#!/bin/bash

# Define as cores
COLOR_GREEN='\033[0;32m'
COLOR_YELLOW='\033[1;33m'
COLOR_CYAN='\033[0;36m'
COLOR_RESET='\033[0m'

# Define o diretório de logs do Exim
logs_path="/var/log"

# Define o número de dias para analisar
days=5

# Obtém o timestamp de 5 dias atrás
start_time=$(date -d "$days days ago" "+%Y-%m-%d")

# Obtém o timestamp atual
end_time=$(date "+%Y-%m-%d")
echo ""
echo ""
# Exibe o intervalo de tempo que estamos analisando
echo -e "${COLOR_CYAN}Processing logs from $start_time to $end_time${COLOR_RESET}"
echo ""

# Exibe o total de mensagens na fila atualmente
total_queue=$(exim -bpc)
echo -e "${COLOR_YELLOW}Total messages in queue: $total_queue${COLOR_RESET}"
echo ""
echo ""

# Exibe as mensagens enviadas por scripts
echo -e "${COLOR_GREEN}Current working directories:${COLOR_RESET}"
echo "----------------------------"
grep "cwd=" /var/log/exim_mainlog | awk '{print $0}' | cut -d"=" -f2 | awk '{print $1}' | grep "^/home" | sort | uniq -c | sort -rn | awk '{print $2 ": " $1}'
echo ""
echo ""

# Exibe a mensagem antes de listar as contas de e-mail
echo -e "${COLOR_GREEN}Logins used to send mail:${COLOR_RESET}"
echo "--------------------------"

# Inicializa um array associativo para armazenar os contadores de mensagens por conta de e-mail
declare -A emails_count

# Itera sobre os arquivos de log do Exim no diretório especificado
for logfile in $(find $logs_path -type f -name "exim_mainlog*" -mtime -$days); do
    # Filtra as linhas relevantes dos logs e conta as mensagens enviadas por cada conta de e-mail
    awk -v start_time="$start_time" -v end_time="$end_time" '
        $1 >= start_time && $1 <= end_time {
            email = ""
            if (match($0, /<=\s+([^ ]+@[^\ ]+)/, matches)) {
                email = matches[1]
                emails_count[email]++
            }
        }
        END {
            for (email in emails_count) {
                print emails_count[email], email
            }
        }
    ' $logfile
done | sort -rn | head -n 10
