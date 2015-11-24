#!/bin/bash
export INSTALL_ROOT=/var/www/courtlistener
export SETTINGS_PATH=$INSTALL_ROOT/cl/settings

cd $INSTALL_ROOT
git clone -b opinion-split https://github.com/freelawproject/courtlistener.git .
chown -R vagrant:vagrant $INSTALL_ROOT
cp $SETTINGS_PATH/05-private.example $SETTINGS_PATH/05-private.py
python -c "from random import choice; print 'SECRET_KEY = \''+''.join([choice('abcdefghijklmnopqrstuvwxyz0123456789') for i in range(50)])+'\''" >> $SETTINGS_PATH/05-private.py
