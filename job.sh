#!/bin/bash

source /root/.environment

mkdir -p /dumps/folder
mkdir -p /dumps/tars

FOLDER=dump-$(date "+%Y-%m-%d-%H.%M.%S")
DUMP_TAR_PATH=/dumps/tars/${FOLDER}.tar

mongodump -h "${BK_MONGO_HOST}" -u "${BK_MONGO_USER}" -p "${BK_MONGO_PASSWORD}" --out /dumps/folder/${FOLDER} --gzip

if [ $? -ne 0 ]
then
  echo "Cannot create dump for ${BK_MONGO_HOST} user: ${BK_MONGO_USER} folder: /dumps/folder/${FOLDER}" >> /var/log/cron.log
  exit 1
fi


tar -cf ${DUMP_TAR_PATH} /dumps/folder/${FOLDER}/

DROPBOX_HEADER="Dropbox-API-Arg: {\"path\":\"${BK_DROPBOX_FOLDER_PATH}/${FOLDER}.tar\"}"

curl -X POST https://content.dropboxapi.com/2/files/upload \
   --header "Authorization: Bearer ${BK_DROPBOX_TOKEN}" \
   --header 'Content-Type: application/octet-stream' \
   --header "${DROPBOX_HEADER}" \
   --data-binary @"${DUMP_TAR_PATH}"

if [ $? -ne 0 ]
then
  echo "Cannot upload the dump file '${DUMP_TAR_PATH}' into dropbox" >> /var/log/cron.log
  exit 1
fi

echo "Dump file ${DUMP_TAR_PATH} has been created and sent to dropbox!!" >> /var/log/cron.log

# Delete the dump files and tar file to save the container space
rm -rf /dumps/

exit 0
