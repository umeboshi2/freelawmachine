#!/bin/bash
export INSTALL_ROOT=/var/www/courtlistener
export SETTINGS_PATH=$INSTALL_ROOT/cl/settings

# Git the project source and set up a dev version of the 05-private.py
sudo chown -R vagrant:vagrant $INSTALL_ROOT
cp $SETTINGS_PATH/05-private.example $SETTINGS_PATH/05-private.py
python -c "from random import choice; print 'SECRET_KEY = \''+''.join([choice('abcdefghijklmnopqrstuvwxyz0123456789') for i in range(50)])+'\''" >> $SETTINGS_PATH/05-private.py

# Purge Solr indices if they exist
sudo rm -Rf $INSTALL_ROOT/Solr/data*

# Initialize Solr
sudo mv /usr/local/solr/example/solr/collection1/conf/solrconfig.xml /usr/local/solr/example/solr/collection1/conf/solrconfig.orig
sudo ln -s -f $INSTALL_ROOT/Solr/conf/solrconfig.xml /usr/local/solr/example/solr/collection1/conf/solrconfig.xml
sudo ln -s -f $INSTALL_ROOT/Solr/conf/schema.xml /usr/local/solr/example/solr/collection1/conf/schema.xml
sudo cp -r /usr/local/solr/example/solr/collection1 /usr/local/solr/example/solr/audio
sudo cp -r /usr/local/solr/example/solr/collection1 /usr/local/solr/example/solr/opinion_test
sudo cp -r /usr/local/solr/example/solr/collection1 /usr/local/solr/example/solr/audio_test
sudo ln -s -f /var/www/courtlistener/Solr/conf/audio_schema.xml /usr/local/solr/example/solr/audio/conf/schema.xml
sudo ln -s -f /var/www/courtlistener/Solr/conf/audio_schema.xml /usr/local/solr/example/solr/audio_test/conf/schema.xml

# might not be needed due to [develop a680df1] change
sudo service solr start

# sleep a few second to let solr start
sleep 10

# create solr core
cd $INSTALL_ROOT
sudo -u vagrant python manage.py shell < /home/vagrant/create_solr_core.py

# eat your celery
sudo cp $INSTALL_ROOT/scripts/etc/celeryd /etc/default/celeryd
printf "CELERY_BIN='/usr/local/bin/celery' \n\
CELERYD_USER='vagrant' \n\
CELERYD_GROUP='vagrant'\n" \
| sudo tee -a /etc/default/celeryd

# update packaged stuff
cd /usr/local/seal_rookery
git pull
cd /usr/local/reporters_db
git pull

# celery and redis
sudo service celeryd start
sudo service redis_6379 start

# lastly, do any last second upgrades for CourtListener dependencies
cd $INSTALL_ROOT
sudo pip install -r requirements.txt --upgrade
