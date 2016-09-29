# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  config.vm.box = "freelawproject/freelawbox64"

  # Forwarding for CourtListener
  config.vm.network "forwarded_port", guest: 8000, host: 8888
  # Forarding for Solr
  config.vm.network "forwarded_port", guest: 8983, host: 8999

  # Sets up the shared folder. If you already have CourtListener checked out
  # somewhere else on your system, update the first argument to point to that
  # clone of the repo.
  config.vm.synced_folder "./courtlistener", "/var/www/courtlistener", create: true

  # Tweak VM settings for virtualbox here. Feel free to bump up memory or
  # CPU core count as desired, but the defaults should work fine.
  config.vm.provider "virtualbox" do |vb, override|
    vb.gui = false
    vb.memory = "2048"
    vb.cpus = 1
  end

  # pull down the Asible playbooks
  config.vm.provision "shell",
    inline: "git clone https://github.com/freelawproject/freelawmachine /vagrant/freelawmachine"

	# Use Ansible to set up CourtListener
  config.vm.provision :ansible_local do |ansible|
    ansible.provisioning_path = "/vagrant/freelawmachine/ansible"
    ansible.playbook = "freelawbox.yml"
    ansible.limit = "all"
    ansible.inventory_path = "/vagrant/freelawmachine/ansible/config/hosts_local"
  end
end
