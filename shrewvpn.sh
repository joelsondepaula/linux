#!/bin/bash
user=$(whoami)

cd  /home

sudo apt update -y

sudo apt install -y build-essential \
qtcreator \
qt5-default qt5-qmake \
cmake libssl-dev libedit-dev flex bison \

sudo git clone https://github.com/HayfaAbusnina/ike.git

sed -i "s/habusnina/$user/g" /home/ike/source/qikea/moc_qikea.cpp_parameters
sed -i "s/habusnina/$user/g" /home/ike/source/qikec/moc_qikec.cpp_parameters

cd /home/ike/; cmake -DCMAKE_INSTALL_PREFIX=/usr -DQTGUI=YES -DETCDIR=/etc -DNATT=YES; make; sudo make install; sudo ldconfig; sudo mv /etc/iked.conf.sample /etc/iked.conf
