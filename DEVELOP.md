
Some details on using the VM for development...

* Setup PyCharm for remote interpreter mode using Vagrant:
  https://www.jetbrains.com/pycharm/quickstart/configuring_for_vm.html

* If you want to put your Juriscraper and Courtlister source elsewhere other
than in `./vagrant`, then update the following settings in `Vagrantfile`:

  `config.vm.synced_folder`
