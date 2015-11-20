#!/bin/bash
echo '=================================='
echo ' Free Law Machine [CourtListener]'
echo '=================================='

echo '>> Installing base dependencies...'
sudo apt-get -yf install autoconf automake antiword checkinstall curl daemon \
  g++ gcc git imagemagick libjpeg62-dev libpng12-dev libtool libwpd-tools \
  libxml2-dev  libxslt-dev make openjdk-6-jre poppler-utils postgresql \
  postgresql-server-dev-all python-dev python-pip python-simplejson \
  subversion tcl8.5 zlib1g-dev
echo '>> ...complete.'

echo '>> Configuring environment properties...'
sudo bash -c "echo 'INSTALL_ROOT=/var/www/courtlistener' >> /etc/courtlistener"
sudo bash -c "echo 'CL_SOLR_XMX=500M' >> /etc/courtlistener"
source /etc/courtlistener

echo '>> Installing Python dependencies..'
sudo pip install django
sudo pip install django-celery
echo '...installing Stripe...'
sudo pip install --index-url https://code.stripe.com --upgrade stripe

echo '>> Creating development CourtListener directories...'
sudo mkdir /var/log/courtlistener
sudo chown -R vagrant:vagrant /var/log/courtlistener
sudo mkdir -p $INSTALL_ROOT
sudo chwon -R vagrant:vagrant $INSTALL_ROOT

echo '>> Pulling from GIT...'
cd $INSTALL_ROOT
sudo -u vagrant git clone https://github.com/freelawproject/courtlistener .

echo '>> Setting up some stuff...'
PYTHON_SITES_PACKAGES_DIR=`python -c "from distutils.sysconfig import get_python_lib; print get_python_lib()"`
sudo -u vagrant ln -s $PYTHON_SITES_PACKAGES_DIR/django/contrib/admin/media $INSTALL_ROOT/alert/assets/media/adminMedia
