#!/bin/bash -eux

# NOTE: for some reason I can't get the environment_vars to work with packer,
# so for now we need to hardcode the version here
export BOXVERSION=freelawbox64-2.0.2

echo '== VAGRANT PRE-CONFIGURATION =='
echo 'Installing Ansible...'
sudo apt-get install -yf ansible

# sudo configuration
echo 'Setting up sudoers...'
sudo bash -c "echo 'vagrant        ALL=(ALL)       NOPASSWD: ALL'" >> /etc/sudoers.d/vagrant

# Setup password-less SSH for Vagrant SSH
echo 'Setting up SSH keys...'
mkdir -p /home/vagrant/.ssh
chmod 0700 /home/vagrant/.ssh
wget --no-check-certificate \
    https://raw.github.com/mitchellh/vagrant/master/keys/vagrant.pub \
    -O /home/vagrant/.ssh/authorized_keys
chmod 0600 /home/vagrant/.ssh/authorized_keys
chown -R vagrant:vagrant /home/vagrant/.ssh

echo '== VIRTUALBOX CONFIGURATION =='
# Mount the disk image. We don't install CDROM support so Packer will
# 'upload' the file to our Vagrant user's home directory.
echo 'Make sure dependencies are installed...'
sudo apt-get -yf install linux-headers-generic build-essential dkms

echo 'Mounting local VirtualBox Additions ISO...'
cd /tmp
sudo mkdir /tmp/isomount
sudo mount -t iso9660 -o loop /home/vagrant/VBoxGuestAdditions.iso /tmp/isomount

# Install the drivers!
echo 'Installing drivers...'
sudo /tmp/isomount/VBoxLinuxAdditions.run

# Clean up the mess, delete the ISO.
echo 'Cleaning up...'
sudo umount isomount
sudo rm -rf isomount /home/vagrant/VBoxGuestAdditions.iso

################################################################################
# borrowed from https://github.com/boxcutter/ubuntu/blob/master/script/motd.sh
echo "==> Recording box generation date"
date > /etc/vagrant_box_build_date

echo "==> Customizing message of the day"
BOXVERSION=freelawbox64-2.0.2
BUILT_MSG=$(printf 'built: %s' $(date +%Y-%m-%d))
printf '%0.1s' "-"{1..64} > /etc/motd
printf '\n' >> /etc/motd
printf '%3s%-28s%30s' " " "$BOXVERSION" "$BUILT_MSG" >> /etc/motd
printf '\n' >> /etc/motd
printf '%8s%s\n' " " "[https://github.com/freelawproject/freelawmachine]" >> /etc/motd
printf '%0.1s' "-"{1..64} >> /etc/motd
printf '\n' >> /etc/motd

echo "==> Message of the day set to:"
cat /etc/motd
