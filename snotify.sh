#!/bin/bash

rm -f /tmp/mnotify775.txt

printf 'email_account: ' 
read -r mail_account;


printf 'message_id: ' 
read -r message_id;

mailsentqtde=$(cat /var/log/exim_mainlog | grep "A=dovecot_login:$mail_account" | wc -l)

evidence=$(exim -Mvh $message_id | grep -A12 "Received: from")


printf 'May i save the output? [y/n]: '
read -r opt

if [[ "$opt" == "y" ]]; then

echo 'Olá, tudo bem?
 
Durante auditoria recente no servidor, verificamos que a conta de e-mail {'$mail_account'} teve a senha comprometida e estava sendo utilizada para o envio de SPAM, conforme amostra:
 
========================
'$evidence'
========================
 
O trecho do log abaixo comprova que a conta foi acessada com a senha correta:
 
===========
Logins used to send mail:
-------------------------
A=dovecot_login:'$mail_account': '$mailsentqtde'
===========
 
 
=-=-=-=-=-=-=-=-=-=-=-=
Resolução:
=-=-=-=-=-=-=-=-=-=-=-=
 
O acesso a esta conta foi desativado para evitar que o abuso persista. Para voltar a usar esta conta de e-mail você deverá trocar sua senha através do cPanel.
 
Por gentileza certifique-se de que as máquinas que administram estas contas não estão infectadas por trojans/malwares, estes tipos de ameaça geralmente são utilizados nestes casos.  Recomendamos também que troque a senha de todos os seus usuários. Ao modificar a senha de uma conta, sempre utilize letras maiúsculas/minúsculas, números e símbolos.
 
Para auxílio, segue um link do nosso ajuda com os passos para realizar o procedimento de troca da senha para contas de e-mail, via cPanel:

========
https://ajuda.hostdime.com.br/display/SUP/Como+redefinir+a+senha+de+contas+de+email+pelo+cPanel
========

Caso exista alguma dúvida ou dificuldade, não hesite em nos acionar.

Continuamos à disposição.' > /tmp/mnotify775.txt

fi

printf 'May i send the notification? [y/n]: '
read -r opt

if [[ "$opt" == "y" ]]; then

echo "$(cat /tmp/mnotify775.txt)" | mail -s "HostDime Brasil :: Conta comprometida ["$mail_account"]" abuse@hostdime.com.br hostdimeteste@gmail.com

else

    exit;

fi
