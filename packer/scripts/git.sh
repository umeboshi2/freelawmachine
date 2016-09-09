#!/bin/bash
export GIT_VERSION="2.10.0"
echo '=================================='
echo '  Free Law Machine [Git client]'
echo "       Version: $GIT_VERSION"
echo '=================================='

# install latest version of git as Ubunto 14.04 comes with v1.9
sudo mkdir /opt/git
sudo chown vagrant /opt/git
sudo chgrp vagrant /opt/git
cd /opt/git

# use version 2.10 for now
wget https://github.com/git/git/archive/v$GIT_VERSION.tar.gz
tar xvfz v$GIT_VERSION.tar.gz
cd /opt/git/git-$GIT_VERSION

# configure and build!
sudo apt-get -yf install libcurl4-openssl-dev
printf "NO_PERL=YesPlease\n\
NO_TCLTK=YesPlease\n\
NO_GETTEXT=YesPlease\n"\
  | tee -a config.mak
make configure --prefix=/usr/local
make all
sudo make install

# clean up
cd /opt
sudo rm -Rf git
