# sogo-debian-packaging

Build [SOGo](https://sogo.nu/) packages (without OpenChange) for Debian 8 directly from the official git repository - with just one command.

## Prerequisites
1. Install Vagrant: https://www.vagrantup.com/downloads.html
1. Install `vagrant-vbguest` which installs VirtualBox Guest Additions: `vagrant plugin install vagrant-vbguest`
1. Clone this repository

## Build packages
1. Create a `.env` file based on `.env.example` and adjust the values
1. Execute `vagrant up`
1. Done! Find the deb-packages inside the `packages` directory
1. Optional: Destroy the virtual machine with `vagrant destroy` or execute `vagrant halt` to keep it for later use

## See also
+ Docker image for building SOGo packages: https://github.com/pluhmen/docker-sogo-build-jessie
