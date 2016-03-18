# -*- mode: ruby -*-
# vi: set ft=ruby :

# Begin the heinous provisioning script! (formerly in provision.sh)
$script = <<SCRIPT
export INSTALL_ROOT=/var/www/courtlistener
export SETTINGS_PATH=$INSTALL_ROOT/cl/settings

# Git the project source and set up a dev version of the 05-private.py
sudo chown -R vagrant:vagrant $INSTALL_ROOT
cp $SETTINGS_PATH/05-private.example $SETTINGS_PATH/05-private.py
printf "\
from random import choice\n\
f = open('secret_key.txt', 'wb')\n\
key = ''.join([choice('abcdefghijklmnopqrstuvwxyz0123456789') for i in range(50)])\n\
quote = '\\u22'\n\
f.write('SECRET_KEY = ' + quote + key + quote)\n\
f.close()\n" | tee -a keygen.py

python keygen.py
cat secret_key.txt | sudo tee -a $SETTINGS_PATH/05-private.py

# Purge Solr indices if they exist
sudo rm -Rf $INSTALL_ROOT/Solr/data*

# Initialize Solr
sudo mv /usr/local/solr/example/solr/collection1/conf/solrconfig.xml /usr/local/solr/example/solr/collection1/conf/solrconfig.orig
sudo ln -s -f $INSTALL_ROOT/Solr/conf/solrconfig.xml /usr/local/solr/example/solr/collection1/conf/solrconfig.xml
sudo ln -s -f $INSTALL_ROOT/Solr/conf/schema.xml /usr/local/solr/example/solr/collection1/conf/schema.xml
sudo cp -r /usr/local/solr/example/solr/collection1 /usr/local/solr/example/solr/audio
sudo cp -r /usr/local/solr/example/solr/collection1 /usr/local/solr/example/solr/opinion_test
sudo cp -r /usr/local/solr/example/solr/collection1 /usr/local/solr/example/solr/audio_test
sudo ln -s -f /var/www/courtlistener/Solr/conf/audio_schema.xml /usr/local/solr/example/solr/audio/conf/schema.xml
sudo ln -s -f /var/www/courtlistener/Solr/conf/audio_schema.xml /usr/local/solr/example/solr/audio_test/conf/schema.xml

# might not be needed due to [develop a680df1] change
sudo service solr start

# sleep a few second to let solr start
sleep 5

# create solr core
cd $INSTALL_ROOT

# eat your celery
sudo cp $INSTALL_ROOT/scripts/etc/celeryd /etc/default/celeryd
printf "CELERY_BIN='/usr/local/bin/celery' \n\
CELERYD_USER='vagrant' \n\
CELERYD_GROUP='vagrant'\n" \
| sudo tee -a /etc/default/celeryd

# update packaged stuff
cd /usr/local/seal_rookery
git pull
cd /usr/local/reporters_db
git pull

# celery and redis
sudo service celeryd start
sudo service redis_6379 start

# lastly, do any last second upgrades for CourtListener dependencies
cd $INSTALL_ROOT
sudo pip install -r requirements.txt --upgrade

# finally, create Solr core for oral arguments
export SOLR_AUDIO_DATA_DIR=$INSTALL_ROOT/Solr/data_audio
export SOLR_AUDIO_SCHEMA=$INSTALL_ROOT/Solr/conf/audio_schema.xml
export SOLR_AUDIO_INSTANCE_DIR=/usr/local/solr/example/solr/audio
export SOLR_AUDIO_CONFIG=$INSTALL_ROOT/Solr/conf/solrconfig.xml

curl -v -X GET -G \
	"http://127.0.0.1:8983/solr/admin/cores" \
	-d action=CREATE \
	-d name=audio \
	-d config=$SOLR_AUDIO_CONFIG \
	-d instanceDir=$SOLR_AUDIO_INSTANCE_DIR \
	-d schema=$SOLR_AUDIO_SCHEMA \
	-d dataDir=$SOLR_AUDIO_DATA_DIR

SCRIPT

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure(2) do |config|
  # The most common configuration options are documented and commented below.
  # For a complete reference, please see the online documentation at
  # https://docs.vagrantup.com.
  config.vm.box = "freelawproject/freelawbox32"

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.
  config.vm.network "forwarded_port", guest: 8000, host: 8888

  # To open an access port for Solr logs outside the machine, uncomment the
  # following line. Be careful with the admin ui as you could delete cores!
  # config.vm.network "forwarded_port", guest: 8983, host: 8999

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  config.vm.synced_folder "./flp/courtlistener", "/var/www/courtlistener", create: true
  config.vm.synced_folder "./flp/juriscraper", "/usr/local/juriscraper", create: true

  # Provider-specific configuration so you can fine-tune various
  # backing providers for Vagrant. These expose provider-specific options.
  # Example for VirtualBox:
  #
  config.vm.provider "virtualbox" do |vb, override|
  #   # Display the VirtualBox GUI when booting the machine
		vb.customize ["modifyvm", :id, "--vram", "22"]
    vb.gui = false
  #
  #   # Customize the amount of memory on the VM:
  #   vb.memory = "1024"
  end

  # Execute our embedded/inline provisioning script.
  config.vm.provision "shell", inline: $script
end
