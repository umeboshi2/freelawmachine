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

# Solr is now installed. The following sets the config and schema files from the CourtListener code.
# TODO: MOVE TO VAGRANTFILE PROVISIONING
# sudo mv /usr/local/solr/example/solr/collection1/conf/solrconfig.xml /usr/local/solr/example/solr/collection1/conf/solrconfig.orig
# sudo ln -s -f $INSTALL_ROOT/Solr/conf/solrconfig.xml /usr/local/solr/example/solr/collection1/conf/solrconfig.xml
# sudo ln -s -f $INSTALL_ROOT/Solr/conf/schema.xml /usr/local/solr/example/solr/collection1/conf/schema.xml
# sudo cp -r /usr/local/solr/example/solr/collection1 /usr/local/solr/example/solr/audio
# sudo ln -s -f /var/www/courtlistener/Solr/conf/audio_schema.xml /usr/local/solr/example/solr/audio/conf/schema.xml

# fetch the current script from github for now...maybe we
# can switch to an apt-get install of solr-jetty and then
# configure it to point to $INSTALL_ROOT
cd /etc/init.d
sudo wget --no-check-certificate \
 https://raw.githubusercontent.com/freelawproject/courtlistener/opinion-split/scripts/init/solr
sudo chmod 755 /etc/init.d/solr
