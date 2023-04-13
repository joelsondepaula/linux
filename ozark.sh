#!/bin/bash
# Author: Joelson Salustiano
# E-mail: joelson.p@hostdime.com.br
# Last update: added "digmon" function. ##02-01-2023##

# All functions

function ozark (){

echo -e "spamsoft\t\t\t->\t Envio de e-mails do dia por conta\n";
echo -e "addspamhunter\t\t\t->\t Adicionar rotina de execução diária do SpamHunter às 23:30\n" ;
echo -e "devnullcron\t\t\t->\t Adiciona o trecho /dev/null 2>&1 em todas as crons de uma conta\n";
echo -e "cpass\t\t\t\t->\t Alterar senha de conta de e-mail\n";
echo -e "crystalnova\t\t\t->\t Remover e-mails congelados da fila\n";
echo -e "sendmail\t\t\t->\t Envio de e-mail para Hotmail e Gmail\n";
echo -e "strikemail\t\t\t->\t Remove todos os e-mails de uma conta de e-mail da fila\n";
echo -e "ygrep\t\t\t\t->\t Envios conta específica\n";
echo -e "ipsaida\t\t\t\t->\t Mostra o IP de saída de e-mails\n";
echo -e "mnotifybeta\t\t\t->\t Notificação para envio de SPAM\n";
echo -e "checkxmlrpc\t\t\t->\t Verificar as requisições no arquivo xmlrpc.php\n";
echo -e "checkwplogin\t\t\t->\t Verificar as requisições no arquivo wp-login.php\n"; 
echo -e "whoownsdomain\t\t\t->\t Verificar o owner de uma conta a partir do domínio\n";
echo -e "queueclear\t\t\t->\t Apagar fila de e-mails através do path (último recurso)\n";
echo -e "xupas\t\t\t\t->\t Subir ambiente do suporte\n";
echo -e "eximcc\t\t\t\t->\t Limpeza de cache do Exim\n";
echo -e "sslqueueclear\t\t\t->\t Limpa fila do AutoSSL\n";
echo -e "changetimezone\t\t\t->\t Alterar timezone do servidor\n";
echo -e "wordpressfix\t\t\t->\t Substituição de arquivos WordPress sem perda de dados\n";
echo -e "portcheck\t\t\t->\t Verificar IPs com acessos atuais em determinada porta\n";
echo -e "emailsumiu\t\t\t->\t Resync do dovecot para restauração de e-mails que estão no /cur mas não aparecem no webmail\n";
echo -e "digmon\t\t\t\t->\t Informações DNS de um domínio\n";
echo -e "backuphistory\t\t\t->\t Histórico de rotina de backups executadas no servidor\n";
echo -e "domlog\t\t\t\t->\t Verificar requisições de bot ou em arquivos xml/wp-login.php\n";
echo -e "ftpaccess\t\t\t->\t Verificar acessos atuais ao FTP\n";
echo -e "sendhotmail\t\t\t->\t Envio de e-mail para o Hotmail\n";
echo -e "sendgmail\t\t\t->\t Envio de e-mail para o Gmail\n";
echo -e "scheck2\t\t\t\t->\t Verificar utilização de recursos do servidor\n";
echo -e "add360agent\t\t\t->\t Adicionar agente do Plesk 360 monitoring\n";}

ozark;

#ALIASES
alias ls="ls -al --color=always";export LESS="r";
alias spamsoft='bash <(curl -ks https://raw.githubusercontent.com/joelsondepaula/linux/main/spamsoft)';
alias addspamhunter='bash <(curl -ks https://raw.githubusercontent.com/joelsondepaula/linux/main/spamhunter)';
alias devnullcron='bash <(curl -ks https://codex.hostdime.com/scripts/download/devnullcron)';
alias mnotifybeta='bash <(curl -ks https://raw.githubusercontent.com/joelsondepaula/linux/main/snotifybeta.sh)';
alias checkxmlrpc='bash <(curl -ks https://raw.githubusercontent.com/joelsondepaula/linux/main/xmlrpc.sh)';
alias checkwplogin='bash <(curl -ks https://raw.githubusercontent.com/joelsondepaula/linux/main/wplogin.sh)';
alias whoownsdomain='bash <(curl -ks https://raw.githubusercontent.com/joelsondepaula/linux/main/whoownsdomain.sh)';
alias xupas='eval "$(curl -ks https://codex.hostdime.com/scripts/download/supas)"';
alias changetimezone='bash <(curl -ks https://raw.githubusercontent.com/joelsondepaula/linux/main/changetimezone.sh)';
alias wordpressfix='bash <(curl -ks https://codex.hostdime.com/scripts/download/wordpressfix)';
alias portcheck='bash <(curl -ks https://raw.githubusercontent.com/joelsondepaula/linux/main/portcheck.sh)';
alias backuphistory='bash <(curl -ks https://codex.hostdime.com/scripts/download/cpbackupspeed)';
alias domlog='bash <(curl -ks https://raw.githubusercontent.com/joelsondepaula/linux/main/domlogs.sh)';
alias scheck2='bash <(curl -ks https://codex.hostdime.com/scripts/download/scheck2)';
alias add360agent='wget -q -N monitoring.platform360.io/agent360.sh && bash agent360.sh 634d9e3c1c270f0ba10fe6e7';


#SCRIPTS

#function changemail_password do Ambiente de suporte
function cpass(){
user=${1}
domain=$(echo $user | cut -d@ -f2)
#domain_verify
account=$(grep $domain /etc/*userdomains | cut -d: -f3 | head -1 | sed 's/ //g')
#mail_verify

password=$(openssl rand 10 -base64)

uapi --user=$account Email passwd_pop email=$user password=$password domain=$domain >> /dev/null
echo -e "The mail account \033[1;33m$user\033[0m have a new password \033[1;33m$password\033[0m";
}
#function changemail_password do Ambiente de suporte


function crystalnova(){

exim -bp|grep frozen|awk '{print $3}' |xargs exim -Mrm


}

function sendmail(){

echo "TesteHDBR" | exim -r root@$HOSTNAME -v -odf testehostdime@hotmail.com hostdimeteste@gmail.com

}

function strikemail(){

mailaccount=${1}

exiqgrep -i -f "$mailaccount" | xargs exim -Mrm

}

function ygrep(){

accountmail=${1}

zgrep -E "A=dovecot_(login|plain):"$accountmail"" /var/log/exim_mainlog*
}


#by macaxeira.sh:
function ipsaida(){

IP_DE_SAIDA=$(cat /etc/exim.conf | grep 'interface' | egrep -o "(((1[0-9]|[1-9]?)[0-9]|2([0-4][0-9]|5[0-5]))\.){3}((1[0-9]|[1-9]?)[0-9]|2([0-4][0-9]|5[0-5]))" | head -n 1)
     if [[ -z $IP_DE_SAIDA ]]; then
        cat /var/cpanel/mainip && echo -e ""
     else
        echo "$IP_DE_SAIDA"

     fi
}

function queueclear(){

rm -rvf /var/spool/exim/input/

}

function eximcc(){

cd /var/spool/exim/db && rm -f retry retry.lockfile && rm -f wait-remote_smtp wait-remote_smtp.lockfile && service exim restart


}

function sslqueueclear(){

mv /var/cpanel/autossl_queue_cpanel.sqlite /var/cpanel/autossl_queue_cpanel.sqlite.bkp

}

function emailsumiu(){

mailaccount=${1}

doveadm force-resync -u $mailaccount INBOX
}

function digmon(){

domain=${1}

dig $domain ANY +noall +answer

}

function ftpaccess(){

ftptype=${1}

if [ "$ftptype" == pure ]

then

/usr/sbin/pure-ftpwho -v

elif [ "$ftptype" == pro ]

then

/usr/bin/ftpwho -v

else

echo "Invalid Option, enguiçado"
echo -e "Use \"pure\" for PURE-FTPD or \"pro\" for PROFTPD"

fi

}

function sendhotmail(){

echo "Mensagem de teste" | exim -r root@$HOSTNAME -v -odf testehostdime@hotmail.com

}

function sendgmail(){

echo "Mensagem de teste" | exim -r root@$HOSTNAME -v -odf hostdimeteste@gmail.com

}

