#!/bin/bash
# DOES THIS REALLY RUN IN BASH WHEN USING PACKER?!? Could cause issues if no

echo '=================================='
echo ' Free Law Machine [CourtListener]'
echo '=================================='

echo '>> Installing base dependencies...'
sudo apt-get -yf install autoconf automake antiword checkinstall curl daemon \
  g++ gcc git imagemagick libjpeg62-dev libpng12-dev libtool libwpd-tools \
  libxml2-dev  libxslt-dev make openjdk-6-jre poppler-utils postgresql \
  postgresql-server-dev-all python-dev python-pip python-simplejson \
  subversion tcl8.5 zlib1g-dev python-psycopg2
echo '>> ...complete.'

echo '>> Configuring environment properties...'
export INSTALL_ROOT=/var/www/courtlistener
sudo bash -c "echo $'INSTALL_ROOT=\"/var/www/courtlistener\"' >> /etc/courtlistener"
sudo bash -c "echo $'CL_SOLR_XMX=\"500M\"' >> /etc/courtlistener"

echo '>> Installing Django dependencies..'
sudo pip install Django==1.6
sudo pip install django-celery
sudo pip install django-cors-headers
sudo pip install django-tastypie
sudo pip install django-debug-toolbar==1.3
sudo pip install django-localflavor
sudo pip install httplib2

echo '...installing Stripe...'
sudo pip install --index-url https://code.stripe.com --upgrade stripe

echo '>> Creating development CourtListener directories...'
sudo mkdir /var/log/courtlistener
sudo chown -R vagrant:vagrant /var/log/courtlistener
sudo mkdir -p $INSTALL_ROOT
sudo chown -R vagrant:vagrant $INSTALL_ROOT

echo '>> Pulling from GIT...'
cd $INSTALL_ROOT
sudo -u vagrant git clone https://github.com/freelawproject/courtlistener $INSTALL_ROOT

echo '>> Setting up some stuff...'
# the following doesn't seem to give us the correct path.
# currently returns /usr/lib/python2.7/dist-packages
# but we need /usr/local/lib/python2.7/dist-packages
#PYTHON_SITES_PACKAGES_DIR=`python -c "from distutils.sysconfig import get_python_lib; print get_python_lib()"`
#sudo -u vagrant ln -s /usr/local/lib/python2.7/dist-packages/django/contrib/admin/media $INSTALL_ROOT/alert/assets/media/adminMedia
# TODO: THIS STUFF CONFIRMED BROKEN!!

echo '>> Installing Reporters DB...'
sudo git clone https://github.com/freelawproject/reporters-db /usr/local/reporters_db
sudo ln -s /usr/local/reporters_db  `python -c "from distutils.sysconfig import get_python_lib; print get_python_lib()"`/reporters_db

#echo '>> Installing Seal Rookery...'
#sudo git clone https://github.com/freelawproject/seal-rookery /usr/local/seal_rookery
# TODO: do we need this translated?
# sudo ln -s /usr/local/seal_rookery $INSTALL_ROOT/../.virtualenvs/courtlistener/bin/seal_rookery


echo '>> Prepping CourtListener for PostgreSQL...'
cp $INSTALL_ROOT/alert/settings/05-private.example $INSTALL_ROOT/alert/settings/05-private.py
python -c "from random import choice; print 'SECRET_KEY = \''+''.join([choice('abcdefghijklmnopqrstuvwxyz0123456789') for i in range(50)])+'\''" >> $INSTALL_ROOT/alert/settings/05-private.py
