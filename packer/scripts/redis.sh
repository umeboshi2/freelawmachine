#!/bin/bash
export INSTALL_ROOT=/var/www/courtlistener

echo '=================================='
echo '     Free Law Machine [Redis]'
echo "INSTALL_ROOT=$INSTALL_ROOT"
echo '=================================='

sudo mkdir -p /opt/redis && sudo chown -R vagrant:vagrant /opt/redis
# from http://redis.io/topics/quickstart
cd /opt/redis
wget http://download.redis.io/redis-stable.tar.gz
tar xvzf redis-stable.tar.gz
rm redis-stable.tar*
cd redis-stable
make
sudo make install

sudo mkdir /etc/redis
sudo mkdir /var/redis
sudo cp utils/redis_init_script /etc/init.d/redis_6379
sudo cp redis.conf /etc/redis/6379.conf
sudo mkdir /var/redis/6379
sudo mkdir /var/log/redis

sudo echo 'include /etc/redis/redis_cl_overrides.conf' >> /etc/redis/6379.conf
sudo ln -s $INSTALL_ROOT/scripts/etc/redis_cl_overrides.conf \
 /etc/redis/redis_cl_overrides.conf
