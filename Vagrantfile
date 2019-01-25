# -*- mode: ruby -*-
# vi: set ft=ruby :

$git_script = <<SCRIPT
if [ ! -d /vagrant/ansible ]; then
  git clone https://github.com/freelawproject/freelawmachine /vagrant/freelawmachine
  echo "copying ansible directory to /vagrant"
  cp -a /vagrant/freelawmachine/ansible /vagrant/ansible
fi
SCRIPT

$proxy_script = <<SCRIPT
aptfile=/vagrant/extra/apt-proxy.conf
if [ ! -r /etc/apt/apt.conf.d/000apt-cacher-ng-proxy ]; then
  sudo cp $aptfile /etc/apt/apt.conf.d/000apt-cacher-ng-proxy
  echo "Created /etc/apt/apt.conf.d/000apt-cacher-ng-proxy"
fi
SCRIPT

Vagrant.configure(2) do |config|
  #config.vm.box = "ubuntu/xenial64"
  config.vm.box = "debian-stretch"
  
  # Forwarding for CourtListener
  config.vm.network "forwarded_port", guest: 8000, host: 8000
  config.vm.network "forwarded_port", guest: 8081, host: 8081
  # Forarding for Solr
  config.vm.network "forwarded_port", guest: 8983, host: 8983

  # Sets up the shared folder. If you already have CourtListener checked out
  # somewhere else on your system, update the first argument to point to that
  # clone of the repo.
  config.vm.synced_folder "./courtlistener", "/var/www/courtlistener", create: true

  # Tweak VM settings for virtualbox here. Feel free to bump up memory or
  # CPU core count as desired, but the defaults should work fine.
  config.vm.provider "virtualbox" do |vb, override|
    vb.gui = false
    vb.memory = "2560"
    vb.cpus = 2
  end

  # pull down the Asible playbooks
  config.vm.provision "shell", inline: $git_script
  
  # enable proxies before installing ansible
  # If you have apt-cacher-ng running on your network
  # uncomment the line below and adjust ./extra/apt-proxy.conf
  config.vm.provision "shell", inline: $proxy_script

	# Use Ansible to set up CourtListener
  config.vm.provision :ansible_local do |ansible|
    ansible.compatibility_mode = "2.0"
    ansible.provisioning_path = "/vagrant/ansible"
    ansible.playbook = "freelawmachine.yml"
    ansible.limit = "all"
    ansible.inventory_path = "/vagrant/ansible/config/hosts_local"
    ansible.verbose = "v"
  end
end

#ssh -R /home/bminton/.gnupg/S.gpg-agent:/home/bminton/.gnupg/S-gpg-agent -o "StreamLocalBindUnlink=yes" -l bminton 192.168.1.9
