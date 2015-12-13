#!/bin/bash
export SOLR_VER=4.1.0

echo '=================================='
echo " Free Law Machine [Solr $SOLR_VER]"
echo '=================================='
export INSTALL_ROOT=/var/www/courtlistener

echo "Downloading Solr $SOLR_VER"
cd /usr/local/
sudo wget https://archive.apache.org/dist/lucene/solr/$SOLR_VER/solr-$SOLR_VER.tgz
sudo tar -x -f solr-$SOLR_VER.tgz
sudo mv solr-$SOLR_VER solr
sudo mkdir /var/log/solr

# fetch the current script from github for now...maybe we
# can switch to an apt-get install of solr-jetty and then
# configure it to point to $INSTALL_ROOT
cd /etc/init.d
sudo wget --no-check-certificate \
 https://raw.githubusercontent.com/freelawproject/courtlistener/opinion-split/scripts/init/solr
sudo chmod 755 /etc/init.d/solr

# needs to eventually be migrated to using upstart
sudo update-rc.d solr defaults
