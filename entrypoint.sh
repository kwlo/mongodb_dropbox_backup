#!/bin/bash

# Add /root/.environment
env | grep "BK" | sed 's/^\(.*\)$/export \1/g' > /root/.environment

# add a cron job
echo "$CRON_SCHEDULE /usr/src/app/job.sh" >> /etc/crontab
crontab /etc/crontab

touch /var/log/cron.log

echo "MongoDb host: ${BK_MONGO_HOST}" >> /var/log/cron.log
echo "MongoDb user: ${BK_MONGO_USER}" >> /var/log/cron.log
echo "Dropbox folder path: ${BK_DROPBOX_FOLDER_PATH}" >> /var/log/cron.log
echo "Cron schedule ($CRON_SCHEDULE) has been added" >> /var/log/cron.log

exec "$@"
