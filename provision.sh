#!/bin/bash
export INSTALL_ROOT=/var/www/courtlistener
export SETTINGS_PATH=$INSTALL_ROOT/cl/settings

# Git the project source and set up a dev version of the 05-private.py
sudo chown -R vagrant:vagrant $INSTALL_ROOT
cp $SETTINGS_PATH/05-private.example $SETTINGS_PATH/05-private.py
python -c "from random import choice; print 'SECRET_KEY = \''+''.join([choice('abcdefghijklmnopqrstuvwxyz0123456789') for i in range(50)])+'\''" >> $SETTINGS_PATH/05-private.py

# Initialize Solr
sudo mv /usr/local/solr/example/solr/collection1/conf/solrconfig.xml /usr/local/solr/example/solr/collection1/conf/solrconfig.orig
sudo ln -s -f $INSTALL_ROOT/Solr/conf/solrconfig.xml /usr/local/solr/example/solr/collection1/conf/solrconfig.xml
sudo ln -s -f $INSTALL_ROOT/Solr/conf/schema.xml /usr/local/solr/example/solr/collection1/conf/schema.xml
sudo cp -r /usr/local/solr/example/solr/collection1 /usr/local/solr/example/solr/audio
sudo ln -s -f /var/www/courtlistener/Solr/conf/audio_schema.xml /usr/local/solr/example/solr/audio/conf/schema.xml
sudo service solr start

# sleep a few second to let solr start
sleep 10

# create solr core
cd $INSTALL_ROOT
sudo -u vagrant python manage.py shell < /home/vagrant/create_solr_core.py
