#!/bin/bash
user=$(whoami)

cd  /home

sudo apt update -y

sudo apt install -y build-essential \
qtcreator \
qt5-default qt5-qmake \
cmake libssl-dev libedit-dev flex bison \
git \

sudo git clone https://github.com/HayfaAbusnina/ike.git

sed -i "s/habusnina/$user/g" /home/ike/source/qikea/moc_qikea.cpp_parameters
sed -i "s/habusnina/$user/g" /home/ike/source/qikec/moc_qikec.cpp_parameters

cd /home/ike/; cmake -DCMAKE_INSTALL_PREFIX=/usr -DQTGUI=YES -DETCDIR=/etc -DNATT=YES; make; sudo make install; sudo ldconfig; sudo mv /etc/iked.conf.sample /etc/iked.conf

echo "alias qikea='screen -S qikea -dm bash -c \"qikea; exec bash\"'" >> ~/.bashrc; source ~/.bashrc

echo "Para executar a GUI basta rodar os comandos \"sudo iked\" e posteriormente \"qikea\""
echo "Artigo com as instruções de instalação e configuração: https://hostdime.atlassian.net/wiki/spaces/Suporte/pages/131530998/Instala+o+e+configura+o+do+ShrewVPN+no+Ubuntu+para+conex+o+VPN+DialUP"

exit;
