#!/usr/bin/env bash

set -e

CONFIG_FILE="/data/.env"

if [ ! -f $CONFIG_FILE ]; then
    echo "Error: You need to create a .env file. See .env.example for reference and run 'vagrant provision' to build packages"
    exit 1
fi

set -a
. $CONFIG_FILE
set +a

REPOSITORY_SOGO="https://github.com/inverse-inc/sogo.git"
REPOSITORY_SOPE="https://github.com/inverse-inc/sope.git"
SOGO_GIT_TAG="SOGo-${VERSION_TO_BUILD}"
SOPE_GIT_TAG="SOPE-${VERSION_TO_BUILD}"

PACKAGES_DIR="/data/packages"
PACKAGES_TO_INSTALL="git zip tmpreaper build-essential dpkg-dev devscripts liblasso3 liblasso3-dev gnustep-make libgnustep-base-dev libldap2-dev libpq-dev libmysqlclient-dev libsbjson2.3 libsbjson-dev libmemcached-dev libcurl4-openssl-dev libexpat-dev libpopt-dev"

export DEBIAN_FRONTEND=noninteractive

cd $PACKAGES_DIR

apt-get install -y $PACKAGES_TO_INSTALL

wget -qc https://packages.inverse.ca/SOGo/nightly/2/debian/pool/jessie/w/wbxml2/libwbxml2-dev_0.11.2-1.1_amd64.deb
wget -qc https://packages.inverse.ca/SOGo/nightly/2/debian/pool/jessie/w/wbxml2/libwbxml2-0_0.11.2-1.1_amd64.deb

dpkg -i libwbxml2-0_0.11.2-1.1_amd64.deb
dpkg -i libwbxml2-dev_0.11.2-1.1_amd64.deb

apt-get -f install -y

if [ -d "sope" ]; then
    cd sope
    git pull --force origin master
else
    git clone $REPOSITORY_SOPE
    cd sope
fi

git checkout --force $SOPE_GIT_TAG

if [ ! -d "debian" ]; then
    cp -a packaging/debian debian
fi

./debian/rules

dpkg-checkbuilddeps && dpkg-buildpackage

cd $PACKAGES_DIR

dpkg -i libsope*.deb

if [ -d "sogo" ]; then
    cd sogo
    git pull --force origin master
else
    git clone $REPOSITORY_SOGO
    cd sogo
fi

git checkout --force $SOGO_GIT_TAG

if [ -d "debian" ]; then
    rm -rf debian
fi

cp -a packaging/debian debian

dch --newversion $VERSION_TO_BUILD "Automated build for version $VERSION_TO_BUILD"

cp packaging/debian-multiarch/control-no-openchange debian

./debian/rules

dpkg-checkbuilddeps && dpkg-buildpackage -b

cd $PACKAGES_DIR

dpkg -i sope4.9-gdl1-mysql_4.9.r1664_amd64.deb
dpkg -i sope4.9-libxmlsaxdriver_4.9.r1664_amd64.deb
dpkg -i "sogo_${VERSION_TO_BUILD}_amd64.deb"
