#!/bin/bash
user=$(whoami)

cd  /home

sudo apt update

sudo apt install build-essential \
qtcreator \
qt5-default qt5-qmake \
cmake libssl-dev libedit-dev flex bison \

sudo git clone https://github.com/HayfaAbusnina/ike.git

sudo sed -i "s/habusnina/$user/g" /home/ike/source/qikea/moc_qikea.cpp_parameters
sudo sed -i "s/habusnina/$user/g" /home/ike/source/qikec/moc_qikec.cpp_parameters

cd /home/ike/; sudo cmake -DCMAKE_INSTALL_PREFIX=/usr -DQTGUI=YES -DETCDIR=/etc -DNATT=YES; sudo make; sudo make install; sudo ldconfig; sudo mv /etc/iked.conf.sample /etc/iked.conf

echo "alias qikea='screen -S qikea -dm bash -c \"qikea; exec bash\"'" >> ~/.bashrc; source ~/.bashrc

echo "Para executar a GUI basta rodar os comandos \"sudo iked\" e posteriormente \"qikea\""
echo -e "Artigo com as instruções de instalação e configuração: https://hostdime.atlassian.net/wiki/spaces/Suporte/pages/131530998/Instala+o+e+configura+o+do+ShrewVPN+no+Ubuntu+para+conex+o+VPN+DialUP"

exit;
