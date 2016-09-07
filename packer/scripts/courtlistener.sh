#!/bin/bash
# DOES THIS REALLY RUN IN BASH WHEN USING PACKER?!? Could cause issues if no
export CL_BRANCH=master

echo '=================================='
echo ' Free Law Machine [CourtListener]'
echo "    branch: $CL_BRANCH"
echo '=================================='

echo '>> Generating and configuring proper en_US.utf8 locale...'
sudo locale-gen
sudo update-locale LANG=en_US.utf8 LANGUAGE=en_US:utf8

echo '>> Installing base dependencies...'
sudo apt-get -yf install autoconf automake antiword checkinstall curl daemon \
  g++ git gcc imagemagick libjpeg62-dev libpng12-dev libtool libwpd-tools \
  libxml2-dev libxslt-dev make openjdk-6-jre poppler-utils postgresql \
  postgresql-server-dev-all python-dev python-pip python-simplejson \
  subversion tcl8.5 zlib1g-dev python-psycopg2
echo '>> ...complete.'

echo '>> Configuring environment properties...'
export INSTALL_ROOT=/var/www/courtlistener
sudo bash -c "echo $'INSTALL_ROOT=\"/var/www/courtlistener\"' >> /etc/courtlistener"
sudo bash -c "echo $'CL_SOLR_XMX=\"500M\"' >> /etc/courtlistener"

echo '>> Creating development CourtListener directories...'
sudo mkdir /var/log/courtlistener
sudo chown -R vagrant:vagrant /var/log/courtlistener
sudo mkdir -p $INSTALL_ROOT
sudo chown -R vagrant:vagrant $INSTALL_ROOT

echo '>> Installing Reporters DB...'
sudo git clone https://github.com/freelawproject/reporters-db /usr/local/reporters_db
sudo ln -s /usr/local/reporters_db  `python -c "from distutils.sysconfig import get_python_lib; print get_python_lib()"`/reporters_db

echo '>> Installing Judge Pics...'
sudo git clone https://github.com/freelawproject/judge-pics /usr/local/judge_pics
sudo ln -s /usr/local/judge_pics `python -c "from distutils.sysconfig import get_python_lib; print get_python_lib()"`/judge_pics

echo '>> Installing non-Python dependencies ...'
sudo apt-get -yf install libav-tools libffi-dev
sudo apt-get -yf install python-numpy python-scipy libblas-dev liblapack-dev \
  gfortran python-dev cython

echo '>> Installing CourtListener Python requirements..'
cd ~
wget --no-check-certificate \
 https://raw.githubusercontent.com/freelawproject/courtlistener/$CL_BRANCH/requirements.txt
sudo -H pip install -r requirements.txt --upgrade
