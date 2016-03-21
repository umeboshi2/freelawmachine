#!/bin/bash
export SCRAPER_BRANCH=issue-59-pip

echo '=================================='
echo ' Free Law Machine [Juriscraper]'
echo "    branch: $SCRAPER_BRANCH"
echo '=================================='

export ARCH=i686 # change to x86_64 for 64-bit

# install the dependencies
echo 'Installing dependencies...'
sudo apt-get install libxml2-dev libxslt-dev


echo 'Installing PhantomJS...'
# Install PhantomJS
sudo pip install selenium

# modified
mkdir /home/vagrant/phantomjs ; cd /home/vagrant/phantomjs
# 64bit: wget https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-1.9.7-linux-x86_64.tar.bz2
wget https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-1.9.7-linux-$ARCH.tar.bz2
# 64bit: tar -x -f phantomjs-1.9.7-linux-x86_64.tar.bz2
tar -x -f phantomjs-1.9.7-linux-$ARCH.tar.bz2
sudo mkdir -p /usr/local/phantomjs
# 64bit: sudo mv phantomjs-1.9.7-linux-x86_64/bin/phantomjs /usr/local/phantomjs
sudo mv phantomjs-1.9.7-linux-$ARCH/bin/phantomjs /usr/local/phantomjs
rm -r phantomjs-1.9.7*  # Cleanup
cd /home/vagrant ; rm -Rf phantomjs

echo 'Preparing location for Juriscaper code...'
# Finally, install the code
# TODO: Move GIT stuff to host machine and just prep guest
sudo mkdir /usr/local/juriscraper  # or somewhere else or `mkvirtualenv juriscraper`
sudo chown -R vagrant:vagrant /usr/local/juriscraper

#echo 'Installing current Juriscraper python dependencies...'
# REMOVED AS THE FOCUS IS CURRENTLY TO USE JURISCRAPER WITHIN COURTLISTENER

# add Juriscraper to your python path (in Ubuntu/Debian)
sudo ln -s /usr/local/juriscraper \
 `python -c "from distutils.sysconfig import get_python_lib; print get_python_lib()"`/juriscraper

echo 'Setting up Juriscraper log dir...'
# create a directory for logs (this can be skipped, and no logs will be created)
sudo mkdir -p /var/log/juriscraper
sudo chown vagrant:vagrant /var/log/juriscraper


echo 'Downloading Seal Rookery (This takes awhile! Grab some coffee)...'
cd /usr/local
sudo git clone https://github.com/freelawproject/seal-rookery /usr/local/seal_rookery
sudo ln -s `pwd`/seal_rookery `python -c "from distutils.sysconfig import get_python_lib; print get_python_lib()"`/seal_rookery
