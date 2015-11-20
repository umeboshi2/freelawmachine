#!/bin/bash -eux

# sudo configuration
#echo "vagrant        ALL=(ALL)       NOPASSWD: ALL" >> /etc/sudoers
#sed -i "s/^.*requiretty/#Defaults requiretty/" /etc/sudoers

# Setup password-less SSH for Vagrant SSH
mkdir -p /home/vagrant/.ssh
chmod 0700 /home/vagrant/.ssh
wget --no-check-certificate \
    https://raw.github.com/mitchellh/vagrant/master/keys/vagrant.pub \
    -O /home/vagrant/.ssh/authorized_keys
chmod 0600 /home/vagrant/.ssh/authorized_keys
chown -R vagrant /home/vagrant/.ssh

# make mapping directory for /vagrant
sudo mkdir /vagrant
