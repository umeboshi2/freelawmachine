#!/bin/bash -eux

echo '== VAGRANT PRE-CONFIGURATION =='
# sudo configuration
echo 'Setting up sudoers...'
sudo echo "vagrant        ALL=(ALL)       NOPASSWD: ALL" >> /etc/sudoers.d/vagrant

# Setup password-less SSH for Vagrant SSH
echo 'Setting up SSH keys...'
mkdir -p /home/vagrant/.ssh
chmod 0700 /home/vagrant/.ssh
wget --no-check-certificate \
    https://raw.github.com/mitchellh/vagrant/master/keys/vagrant.pub \
    -O /home/vagrant/.ssh/authorized_keys
chmod 0600 /home/vagrant/.ssh/authorized_keys
chown -R vagrant /home/vagrant/.ssh

# make mapping directory for /vagrant
echo 'Setting up /vagrant...'
sudo mkdir /vagrant
sudo chown vagrant:vagrant /vagrant

echo '== VIRTUALBOX CONFIGURATION =='
# Mount the disk image
echo 'Mounting VirtualBox Additions ISO...'
cd /tmp
sudo mkdir /tmp/isomount
sudo mount -t iso9660 -o loop $VBOXISO /tmp/isomount

# Install the drivers
echo 'Installing drivers...'
sudo /tmp/isomount/VBoxLinuxAdditions.run

# Cleanup
echo 'Cleaning up...'
sudo umount isomount
sudo rm -rf isomount $VBOXISO
###
