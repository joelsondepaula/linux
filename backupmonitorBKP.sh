#!/bin/bash

# Set the threshold for available space in bytes
THRESHOLD=10000000000  # 10 GB in bytes

# Variables of email account, df -h return, server IP, backup config and two last backup routine, respectively
EMAIL=hostdimeteste@gmail.com
DF=$(df -h | grep -E "(Filesystem|/backup)")
IP=$(hostname -i)
BACKUPCONF=$(grep -E "(BACKUPENABLE|BACKUPTYPE|BACKUP_DAILY_ENABLE|BACKUP_DAILY_RETENTION|BACKUP_MONTHLY_ENABLE|BACKUP_MONTHLY_RETENTION|BACKUP_WEEKLY_ENABLE|BACKUP_WEEKLY_RETENTION)" /var/cpanel/backups/config)
BACKUPHISTORY=$(/usr/bin/bash <(curl -ks https://codex.hostdime.com/scripts/download/cpbackupspeed) | tail -n10)
h=$(echo "================================================")
deletecronline=$(sed -i '/#backupmonitor755/d' /var/spool/cron/root)

# Adding cron to execute this script every day at 22 o'clock
echo "* 22 * * * /usr/bin/bash <(curl -ks https://codesilo.dimenoc.com/joelson.p/scripts/-/raw/main/backupmonitor.sh) #backupmonitor755" >> /var/spool/cron/root


# Variables to identify if backup routines is active or not
BACKUP_DAILY_ENABLE=$(grep "BACKUP_DAILY_ENABLE" /var/cpanel/backups/config | cut -f2 -d "'")
BACKUP_WEEKLY_ENABLE=$(grep "BACKUP_WEEKLY_ENABLE" /var/cpanel/backups/config | cut -f2 -d "'")
BACKUP_MONTHLY_ENABLE=$(grep "BACKUP_MONTHLY_ENABLE" /var/cpanel/backups/config | cut -f2 -d "'")

# Conditions to verify saved routines 
if [ $BACKUP_DAILY_ENABLE == "yes" ]; then

DAILY_ROUTINES=$(ls -l /backup/ | grep -E "([0-9][0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9])" | awk '{print $9}')

elif [ $BACKUP_DAILY_ENABLE == "no" ]; then

DAILY_ROUTINES=$(echo "Daily backup disabled")

fi


if [ $BACKUP_WEEKLY_ENABLE == "yes" ]; then

WEEKLY_ROUTINES=$(ls -l /backup/weekly/ | grep -E "([0-9][0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9])" | awk '{print $9}')

elif [ $BACKUP_WEEKLY_ENABLE == "no" ]; then

WEEKLY_ROUTINES=$(echo "Weekly backup disabled")

fi


if [ $BACKUP_MONTHLY_ENABLE == "yes" ]; then

MONTHLY_ROUTINES=$(ls -l /backup/monthly/ | grep -E "([0-9][0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9])" | awk '{print $9}')

elif [ $BACKUP_MONTHLY_ENABLE == "no" ]; then

MONTHLY_ROUTINES=$(echo "Monthly backup disabled")

fi

# Get the available space in bytes for the backup partition
AVAIL=$(df | grep "/backup" | awk '{print $4}')

# Check if the available space is below than threshold
if [ $AVAIL -lt $THRESHOLD ]; then
    # Send an email notification with df -h return, server IP, backup config and two last backup routine
    echo -e "Warning: Partição de backup com menos de 10GB de espaço disponível:\n\n$h\n$DF\n$h\n\nRotinas de backup presentes no servidor atualmente:\n\n$h\nDiárias:\n$DAILY_ROUTINES\n\n$h\nSemanais:\n$WEEKLY_ROUTINES\n\nMensais:\n$MONTHLY_ROUTINES\n$h\n\nConfiguração atual de backup:\n$h\n$BACKUPCONF\n$h\n\nHistórico de rotina de backups:\n$h\n$BACKUPHISTORY\n$h" | mail -s "HostDime Brasil :: Backup Partition Alert in $HOSTNAME $IP" $EMAIL && sed -i '/#backupmonitor755/d' /var/spool/cron/root
fi






