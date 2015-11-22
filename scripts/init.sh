#!/bin/bash

echo '=================================='
echo ' Free Law Machine [SysV]'
echo '=================================='

export INSTALL_ROOT=/var/www/courtlistener

sudo ln -s $INSTALL_ROOT/scripts/init/solr /etc/init.d/solr
sudo ln -s $INSTALL_ROOT/scripts/log/solr /etc/logrotate.d/solr

sudo ln -s $INSTALL_ROOT/scripts/init/scraper /etc/init.d/scraper
sudo ln -s $INSTALL_ROOT/scripts/log/scraper /etc/logrotate.d/scraper
