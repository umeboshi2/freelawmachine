#!/bin/bash -eux
# NOTE: Do we need all the sudo's? I don't think so...

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
chown -R vagrant:vagrant /home/vagrant/.ssh

# make mapping directory for /vagrant
echo 'Setting up /vagrant...'
sudo mkdir /vagrant
sudo chown vagrant:vagrant /vagrant

echo '== VIRTUALBOX CONFIGURATION =='
# Mount the disk image. We don't install CDROM support so Packer will
# 'upload' the file to our Vagrant user's home directory.
echo 'Make sure dependencies are installed...'
sudo apt-get -yf install linux-headers-generic build-essential dkms

echo 'Mounting local VirtualBox Additions ISO...'
cd /tmp
sudo mkdir /tmp/isomount
sudo mount -t iso9660 -o loop /home/vagrant/$VBOX_ISO /tmp/isomount

# Install the drivers!
echo 'Installing drivers...'
sudo /tmp/isomount/VBoxLinuxAdditions.run

# Clean up the mess, delete the ISO.
echo 'Cleaning up...'
sudo umount isomount
sudo rm -rf isomount $VBOX_ISO
###
