#!/bin/bash
# TODO: MOVE TO Vagrantfile
echo '=================================='
echo '     Free Law Machine [SysV]'
echo '=================================='

export INSTALL_ROOT=/var/www/courtlistener

# should be safe to make these all prior to the files/code actually being there

sudo ln -s $INSTALL_ROOT/scripts/init/solr /etc/init.d/solr
sudo ln -s $INSTALL_ROOT/scripts/log/solr /etc/logrotate.d/solr

sudo ln -s $INSTALL_ROOT/scripts/init/scraper /etc/init.d/scraper
sudo ln -s $INSTALL_ROOT/scripts/log/scraper /etc/logrotate.d/scraper

sudo ln -s $INSTALL_ROOT/scripts/log/redis /etc/logrotate.d/redis

sudo ln -s $INSTALL_ROOT/scripts/log/celery /etc/logrotate.d/celery
sudo ln -s $INSTALL_ROOT/scripts/init/celeryd /etc/init.d/celeryd
