# Backup container for mongo instances to dropbox account

Docker image to run a cron job creating and upload mongoDb backups to your dropbox account

Following ENV variables must be specified:
 - `BK_MONGO_HOST` - Hostname of the mongo server
 - `BK_MONGO_USER` - Username (Optional)
 - `BK_MONGO_PASSWORD` - Password (Optional)
 - `BK_DROPBOX_FOLDER_PATH` - Dropbox directory path to store the backup files 
 - `BK_DROPBOX_TOKEN` - Dropbox access token. Look for it in the Dropbox.com developer page
 - `CRON_SCHEDULE` cron schedule string (Ex: "0 0 * * *" to backup the server each midnight server time)

## Retrieve Dropbox access token
Go to:
    https://dropbox.github.io/dropbox-api-v2-explorer/#files_list_folder
Click on `Get Token`

## Check Docker Container Status
    docker exec -it <Docker Container ID> /usr/bin/tail -f /var/log/cron.log
