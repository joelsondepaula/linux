#!/bin/bash

cd /root \
wget https://download.configserver.com/csf.tgz \
tar -xzf csf.tgz \
cd csf \
./install.cpanel.sh

end