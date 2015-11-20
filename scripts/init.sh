#!/bin/bash
echo '=========================='
echo 'Free Law Machine [init.sh]'
echo '=========================='

echo '>> Installing base dependencies...'
sudo apt-get -yf install autoconf automake antiword checkinstall curl daemon \
  g++ gcc git imagemagick libjpeg62-dev libpng12-dev libtool libwpd-tools \
  libxml2-dev  libxslt-dev make openjdk-6-jre poppler-utils postgresql \
  postgresql-server-dev-all python-dev python-pip python-simplejson \
  subversion tcl8.5 zlib1g-dev
echo '>> ...complete.'

echo '>> Configuring environment properties...'
sudo echo 'CL_SOLR_XMX=500M' > /etc/courtlistener

echo '>> Installing Python dependencies..'
echo '...installing Stripe...'
sudo -H pip install --index-url https://code.stripe.com --upgrade stripe

echo '>> Creating development CourtListener directories...'
sudo mkdir /var/log/courtlistener
sudo chown -R vagrant:vagrant /var/log/courtlistener
