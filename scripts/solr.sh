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

# run the script jobby
cd $INSTALL_ROOT
