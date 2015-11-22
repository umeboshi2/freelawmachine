#!/bin/bash

echo '=================================='
echo ' Free Law Machine [SysV]'
echo '=================================='

export INSTALL_ROOT=/var/www/courtlistener

sudo ln -s $INSTALL_ROOT/init-scripts/solr /etc/init.d/solr
sudo ln -s $INSTALL_ROOT/log-solr/solr /etc/logrotate.d/solr

sudo ln -s $INSTALL_ROOT/init-scripts/scraper /etc/init.d/scraper
sudo ln -s $INSTALL_ROOT/log-solr/scraper /etc/logrotate.d/scraper
