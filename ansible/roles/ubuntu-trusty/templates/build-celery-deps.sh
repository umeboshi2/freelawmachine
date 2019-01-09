#!/bin/bash
set -e

pushd ~/workspace


lcp=libarchive-cpio-perl-0.10
lcpdeb=libarchive-cpio-perl_0.10-1_all.deb
if [ ! -d $lcp ]; then
    apt-get source libarchive-cpio-perl
    pushd $lcp
    dpkg-buildpackage -us -uc
    sudo debi
    popd
fi
echo "Finished libarchive-cpio-perl **********************"

dhr12=dh-autoreconf-12~ubuntu16.04.1
dhr12deb=dh-autoreconf_12~ubuntu16.04.1_all.deb
if [ ! -d $dhr12 ]; then
    apt-get source dh-autoreconf=12
    pushd $dhr12
    dpkg-buildpackage -us -uc
    popd
    sudo dpkg -i $dhr12deb
fi
echo "Finished $dhr12deb  *******************************"

dh10=debhelper-10.2.2ubuntu1~ubuntu16.04.1
dh10deb=debhelper_10.2.2ubuntu1~ubuntu16.04.1_all.deb
if [ ! -d $dh10 ]; then
    apt-get source debhelper=10
    pushd $dh10
    dpkg-buildpackage -us -uc
    sudo debi
    popd
fi
echo "Finished $dh10deb  *******************************"


if [ ! -d dh-autoreconf-19 ]; then
    apt-get source dh-autoreconf
    pushd dh-autoreconf-19
    # we technically need debhelper 11
    # but we should manage be able to manage with this
    # until after debhelper 12 is built
    dpkg-buildpackage -us -uc -d
    sudo debi
    popd
fi
echo "Finished dh-autoreconf-19  *******************************"


if [ ! -d dwz-0.12 ]; then
    apt-get source dwz
    pushd dwz-0.12
    dpkg-buildpackage -us -uc
    sudo debi
    popd
fi    
echo "Finished dwz  ********************************************"

oldstripper=strip-nondeterminism-0,034
if [ ! -d $oldstripper ]; then
    apt-get source strip-nondeterminism=0.034-1
    pushd $oldstripper
    dpkg-buildpackage -us -uc
    sudo debi
    popd
fi
echo "finished strip-nondeterminism-0,034 **********************"

stripper=strip-nondeterminism-1.0.0
if [ ! -d $stripper ]; then
    apt-get source strip-nondeterminism
    pushd $stripper
    dpkg-buildpackage -us -uc -d
    popd
fi

sudo dpkg -i dh-strip-nondeterminism_1.0.0-1_all.deb libfile-stripnondeterminism-perl_1.0.0-1_all.deb


if [ ! -d debhelper-12 ]; then
    apt-get source debhelper
    pushd debhelper-12
    dpkg-buildpackage
    popd
fi

#sudo dpkg -i debhelper_12_all.deb dh-systemd_12_all.deb
