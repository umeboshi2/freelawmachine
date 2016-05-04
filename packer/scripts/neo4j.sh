#!/bin/bash
export INSTALL_ROOT=/var/www/courtlistener
export NEO4J_VERSION=3.0.0
echo '=================================='
echo '     Free Law Machine [Neo4j]'
echo "    NEO4J_VERSION=$NEO4J_VERSION"
echo '=================================='

# java 8 ... le sigh
# per http://ubuntuhandbook.org/index.php/2014/09/install-oracle-java-ubuntu-1410/
sudo apt-get install -yf software-properties-common
sudo add-apt-repository -y ppa:webupd8team/java
sudo apt-get update
# per http://stackoverflow.com/questions/19275856/auto-yes-to-the-license-agreement-on-sudo-apt-get-y-install-oracle-java7-instal
echo debconf shared/accepted-oracle-license-v1-1 select true | sudo debconf-set-selections
echo debconf shared/accepted-oracle-license-v1-1 seen true | sudo debconf-set-selections
sudo apt-get install -y oracle-java8-installer

# Raise open file limits.
printf "\n\
* soft nofile 65536 \n\
* hard nofile 65536 \n\
* soft memlock unlimited \n\
* hard memlock unlimited \n\
* soft as unlimited \n\
* hard as unlimited \n" \
  | sudo tee -a /etc/security/limits.conf
printf "\nsession required pam_limits.so\n" \
  | sudo tee -a /etc/pam.d/common-session

# Install Neo4j per http://debian.neo4j.org
wget -O - https://debian.neo4j.org/neotechnology.gpg.key | sudo apt-key add -
printf "deb http://debian.neo4j.org/repo stable/ \n"\
  | sudo tee /tmp/neo4j.list
sudo mv /tmp/neo4j.list /etc/apt/sources.list.d
sudo apt-get update
sudo apt-get install -yf neo4j=$NEO4J_VERSION

# Install neomodule native dependencies
sudo apt-get install -yf libffi-dev

# install neomodel/py2neo to get neoauth tool
sudo pip install neomodel

# !!! totes sketchy and unsafe, so only use for dev !!!
# set password to "courtlistener" for default user "neo4j"
neoauth neo4j neo4j courtlistener
printf "NEO4J_REST_URL=http://neo4j:courtlistener@localhost:7474/db/data/" \
  | sudo tee -a /etc/environment
export NEO4J_REST_URL=http://neo4j:courtlistener@localhost:7474/db/data/
