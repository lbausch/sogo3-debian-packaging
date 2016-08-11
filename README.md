# sogo-debian-packaging

Build [SOGo](https://sogo.nu/) packages (without OpenChange) for Debian 8 directly from the official git repository - with just one command.

## Prerequisites
1. Install Vagrant: https://www.vagrantup.com/downloads.html
1. Install `vagrant-vbguest` which installs VirtualBox Guest Additions: `vagrant plugin install vagrant-vbguest`
1. Clone this repository

## Build packages
1. Execute `vagrant up`
1. Done! Find the deb-packages inside the `packages` directory

## Customization
You may want to change your name (`DEBFULLNAME`) and email address (`DEBEMAIL`) in `build.sh`. There you can also specify the version of SOGo which will be built (`VERSION_TO_BUILD`).

## See also
+ Docker image for building SOGo packages: https://github.com/pluhmen/docker-sogo-build-jessie
