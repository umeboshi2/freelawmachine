Free Law (Virtual) Machine
==========================

This project is designed to provide automation around building a ready-to-run
development environment for the [Free Law Project](https://github.com/freelawproject)
using Vagrant boxes.

Hopefully, it will do away with the manual process described [here](https://github.com/freelawproject/courtlistener/wiki/Installing-CourtListener-on-Ubuntu-Linux)
and make having a dev environment as easy as `vagrant up`.

## Requirements
* [Vagrant 1.7.4](https://www.vagrantup.com)
* [Packer 0.8.x](https://packer.io/downloads.html)
* [Virtualbox 5.x](https://www.virtualbox.org/)

And a network connection since the VM will need to pull down packages.

## Usage
Here's how to crank out a box if you've got the Requirements above.

0. Grab the latest:
`git clone https://github.com/voutilad/freelawmachine ; cd freelawmachine`

1. Get packing:
`packer build flm-packer.json`

2. Install the Vagrant box locally
`vagrant box add packer_virtualbox-iso_virtualbox.box --name freelaw/devbox`

3. Initialize a Vagrantfile
`vagrant init freelaw/trusty32-devbox`

4. Vagrant up!
`vagrant up`

5. Get your popcorn ready and log in
`vagrant ssh`


## Various Details
* Based on Ubuntu Server 32-bit (for now) 14.04 LTS
* Trying to target dev machines that have:
  * 8 GB RAM
  * [Virtualbox 5.x](https://www.virtualbox.org/)
  * Lack of VT-X support (hence 32-bit VM is the initial goal)

## Possible Future Goals
* VMWare support
* 64-bit support
* Prod machine box generation???

## Some References
[A packer template for Vagrant from Hashicorp](https://github.com/hashicorp/atlas-packer-vagrant-tutorial.git)
