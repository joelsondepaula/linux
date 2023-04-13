#!/bin/bash

cd /home/.hd/ && mkdir cloudmark && cd cloudmark

touch cloudmarktrap.sh

chmod +x cloudmarktrap.sh

echo "#!/bin/bash
bash <(curl -ks https://codesilo.dimenoc.com/joelson.p/scripts/-/raw/main/cloudmarkcheck.sh)" >> cloudmarktrap.sh

echo "0 */6 * * * /home/.hd/spamhunter/cloudmarktrap.sh > /dev/null" >> /var/spool/cron/root

exit
