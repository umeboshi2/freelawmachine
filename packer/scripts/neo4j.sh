#!/bin/bash
export INSTALL_ROOT=/var/www/courtlistener
export NEO4J_VERSION=2.3.3
echo '=================================='
echo '     Free Law Machine [Neo4j]'
echo "    NEO4J_VERSION=$NEO4J_VERSION"
echo '=================================='

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
printf 'deb http://debian.neo4j.org/repo stable/' \n
  | sudo tee /tmp/neo4j.list
sudo mv /tmp/neo4j.list /etc/apt/sources.list.d
sudo apt-get update
sudo apt-get install -yf neo4j=$NEO4J_VERSION

# Install neomodule native dependencies
sudo apt-get install -yf libffi-dev
