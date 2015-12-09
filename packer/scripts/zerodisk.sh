#!/bin/bash

sudo apt-get clean

dd if=/dev/zero of=/EMPTY bs=1M
rm -f /EMPTY
sync
sync
sync
