from mongo:3.4

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

COPY . /usr/src/app

RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 0C49F3730359A14518585931BC711F9BA15703C6

RUN apt-get update && apt-get install -y cron curl vim

ENTRYPOINT ["/usr/src/app/entrypoint.sh"]

CMD touch /var/log/cron.log && cron && tail -f /var/log/cron.log

