Free Law (Virtual) Machine v1.0.1
==========================

This project is designed to provide automation around building a ready-to-run
development environment for the [Free Law Project](https://github.com/freelawproject)
using Vagrant boxes.

Hopefully, it will do away with the manual process described [here](https://github.com/freelawproject/courtlistener/wiki/Installing-CourtListener-on-Ubuntu-Linux)
and make having a dev environment as easy as `vagrant up`.

## Requirements
* [Vagrant 1.7.4](https://www.vagrantup.com)
* [Packer 0.8.6](https://packer.io/downloads.html)
* [Virtualbox 5.x](https://www.virtualbox.org/)
* Git

And a high-speed network connection since the VM will need to pull down
packages! (You are installing Ubuntu...so do this via a cellular data connection
at your own $$ peril!)

## How to Get Started

There are two phases to using this project (for the time being):
1. *Building the Vagrant Box* - in the future, this box will be available
prebuilt and hosted online allowing users to skip the Building steps.

2. *Initializing the Vagrant Box* - this is the most common Vagrant task and
is what brings your local Free Law development environment online.

### Building the Vagrant Box
Here's how to crank out a box if you've got the Requirements above. Depending
on your network connection, CPU, disk, etc. this could take anywhere from 5 mins
to maybe 30 mins. Be patient :-)

All of the tools required to build the box using [Packer](https://packer.io)
are contained in the [packer](./packer) directory of this project.

0. Grab the latest Free Law Machine source:

  `git clone https://github.com/voutilad/freelawmachine`

1. Jump into the packer directory:

  `cd packer`

2. Build the box! (Yes, it's that simple. Since it's configured headless, it
may appear nothing is happening for a little while. It's ok.)

  `packer build flm-packer.json`

3. Install the Vagrant box on your local machine. The new _.box_ file will
have a timestamp in the filename, so make sure to add the correct file:

  `vagrant box add freelawbox-trusty32-dev-{timestamp}.box --name freelaw/trusty32-dev`

Voila! You now have a new Vagrant box installed locally. You can even share the
_.box_ file with others the old fashioned way, host it at a URL, etc. Vagrant
supports pulling boxes via URL, so that's an option! (In the future, the box
will most likely be published online making the above steps left to those that
want to customize the box or update it for future versions of CourtListener.)

### Creating a local Free Law Development Environment

Now that you have your box installed (it secretly lives in `~/.vagrant` or your
equivalent), launching a brand-new, clean dev environment is simple.

1. In the root of this project, change to the `vagrant` dir:

  `cd vagrant`

2. We need to now grab the CourtListener and Juriscraper source. At time of
this writing, the following will grab the two relevant branches:

  `git clone -b opinion-split https://github.com/freelawproject/courtlistener.git`

  `git clone -b issue-59-pip https://github.com/freelawproject/juriscraper`

3. Return to the root of this project.

  `cd ..`

4. Now this is where the magic happens! Just run:

  `vagrant up`

5. You should see some logging output and some provisioning output. Now to log
into the box, it's a simple:

  `vagrant ssh`

6. If you haven't used the machine yet, you'll need to do some basic CourtListener
provisioning steps that currently aren't handled (yet) by our Vagrant provisioning
scripts.

  ``` bash
  >cd /var/www/courtlistener
  >./manage.py migrate
  >./manage.py runserver 0.0.0.0:8000
  ```

  Make sure you specified that ip address of 0.0.0.0!!! We need Django to bind to
  the network adapter(s) other than the loopback adapter, otherwise the port
  forwarding set up by Vagrant won't work! (For more details on why this is,
  check out [this StackOverflow post.](http://stackoverflow.com/questions/1621457/about-ip-0-0-0-0-in-django))

7. Fire up your browser (on your local machine!) and confirm you've got a local
instance that looks like [courtlistener.org](https://www.courtlistener.com/).

  Navigate to: [http://localhost:8000](http://localhost:8000)


## Development Tips
If you're playing around, here are some things to remember:
* Vagrant installs boxes typically in your home directory under something like
`.vagrant.d`. Make sure you use the same box name when using `vagrant box add`
and it will replace that existing box. (You probably need to add `--force` or
  something to the command, btw.)
* Vagrant keeps instances of vm's in the local directory where your Vagrantfile
is and where you are running `vagrant up`. Do a simple `vagrant destroy` to
wipe it out when you've built a new box version and want to start over.


## Various Details
* Based on Ubuntu Server 32-bit (for now) 14.04 LTS Trusty Tahr
* Trying to target dev machines that have:
  * 8 GB RAM
  * [Virtualbox 5.x](https://www.virtualbox.org/)
  * Lack of VT-X support (hence 32-bit VM is the initial goal)

## Possible Future Goals
* VMWare support
* 64-bit support - does this matter?
* Help stub out some complicated dependencies (like Solr) to cut down on box
  size and complexity.

## Some References
[A packer template for Vagrant from Hashicorp](https://github.com/hashicorp/atlas-packer-vagrant-tutorial.git)
