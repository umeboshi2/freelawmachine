#!/bin/bash

echo '=================================='
echo '     Free Law Machine [Celery]'
echo '=================================='


sudo mkdir -p /var/run/celery /var/log/celery
sudo chown -R vagrant:vagrant /var/run/celery /var/log/celery

printf "CELERY_BIN='/usr/local/bin/celery' \n\
CELERYD_USER='vagrant' \n\
CELERYD_GROUP='vagrant'\n" \
| sudo tee -a /etc/default/celeryd
