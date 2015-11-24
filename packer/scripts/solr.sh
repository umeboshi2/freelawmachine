#!/bin/bash

echo '=================================='
echo ' Free Law Machine [Solr]'
echo '=================================='
export INSTALL_ROOT=/var/www/courtlistener

cd /usr/local/
sudo wget https://archive.apache.org/dist/lucene/solr/4.1.0/solr-4.1.0.tgz
sudo tar -x -f solr-4.1.0.tgz
sudo mv solr-4.1.0 solr
sudo mkdir /var/log/solr

# Solr is now installed. The following sets the config and schema files from the CourtListener code.
sudo mv /usr/local/solr/example/solr/collection1/conf/solrconfig.xml /usr/local/solr/example/solr/collection1/conf/solrconfig.orig
sudo ln -s -f $INSTALL_ROOT/Solr/conf/solrconfig.xml /usr/local/solr/example/solr/collection1/conf/solrconfig.xml
sudo ln -s -f $INSTALL_ROOT/Solr/conf/schema.xml /usr/local/solr/example/solr/collection1/conf/schema.xml
sudo cp -r /usr/local/solr/example/solr/collection1 /usr/local/solr/example/solr/audio
sudo ln -s -f /var/www/courtlistener/Solr/conf/audio_schema.xml /usr/local/solr/example/solr/audio/conf/schema.xml

# fetch the current script from github for now...maybe we
# can switch to an apt-get install of solr-jetty and then
# configure it to point to $INSTALL_ROOT
cd /etc/init.d
sudo wget --no-check-certificate \
 https://raw.githubusercontent.com/freelawproject/courtlistener/opinion-split/scripts/init/solr
sudo ./solr start
