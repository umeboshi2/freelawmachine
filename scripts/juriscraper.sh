#!/bin/bash
echo '=================================='
echo ' Free Law Machine [Juriscraper]'
echo '=================================='

# SOME FROM: https://github.com/freelawproject/juriscraper/
# install the dependencies
sudo apt-get install libxml2-dev libxslt-dev  # In Ubuntu prior to 14.04 this is libxslt-devel

# Install PhantomJS
sudo -H pip install selenium

# modified
mkdir /home/vagrant/phantomjs ; cd /home/vagrant/phantomjs
wget https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-1.9.7-linux-x86_64.tar.bz2
tar -x -f phantomjs-1.9.7-linux-x86_64.tar.bz2
sudo mkdir -p /usr/local/phantomjs
sudo mv phantomjs-1.9.7-linux-x86_64/bin/phantomjs /usr/local/phantomjs
rm -r phantomjs-1.9.7*  # Cleanup

# Finally, install the code
sudo mkdir /usr/local/juriscraper  # or somewhere else or `mkvirtualenv juriscraper`
cd /usr/local/juriscraper
git clone https://github.com/freelawproject/juriscraper.git .
sudo -H -u vagrant pip install -r requirements.txt

# add Juriscraper to your python path (in Ubuntu/Debian)
sudo ln -s `pwd`/juriscraper `python -c "from distutils.sysconfig import get_python_lib; print get_python_lib()"`/juriscraper

# create a directory for logs (this can be skipped, and no logs will be created)
sudo mkdir -p /var/log/juriscraper
# END FROM
