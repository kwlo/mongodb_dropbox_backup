#!/bin/bash

# Add /root/.environment
env | grep "BK" | sed 's/^\(.*\)$/export \1/g' > /root/.environment

# add a cron job
echo "$CRON_SCHEDULE /usr/src/app/job.sh" >> /etc/crontab
crontab /etc/crontab

exec "$@"
