#!/bin/bash

say Starting packer! && \
packer build freelawbox64-desktop.json && \
say Packer is done! I repeat that Packer is done. && \ 
vagrant box remove freelawproject/freelawbox64-desktop && \
vagrant box add freelawbox64-2.1.0-desktop.box --name freelawproject/freelawbox64-desktop && \
cd ../../ && \
vagrant destroy -f && \
say vagrant up! && \
vagrant up && \
say hey dave vagrant is ready for action! || \
say Oh crap something went wrong!

