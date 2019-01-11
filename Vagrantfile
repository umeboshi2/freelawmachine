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
pipfile=/vagrant/extra/pip.conf
if [ ! -r /etc/apt/apt.conf.d/000apt-cacher-ng-proxy ]; then
  sudo cp $aptfile /etc/apt/apt.conf.d/000apt-cacher-ng-proxy
  echo "Created /etc/apt/apt.conf.d/000apt-cacher-ng-proxy"
fi
if [ ! -r /etc/pip.conf ]; then
  sudo cp $pipfile /etc/pip.conf
  echo "Created /etc/pip.conf"
fi
SCRIPT

Vagrant.configure(2) do |config|
  config.vm.box = "freelawproject/freelawbox64"

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
  config.vm.provision "shell", inline: $proxy_script

	# Use Ansible to set up CourtListener
  config.vm.provision :ansible_local do |ansible|
    ansible.provisioning_path = "/vagrant/ansible"
    ansible.playbook = "freelawbox.yml"
    ansible.limit = "all"
    ansible.inventory_path = "/vagrant/ansible/config/hosts_local"
  end
end
