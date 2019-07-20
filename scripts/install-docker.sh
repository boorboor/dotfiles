#!/usr/bin/env bash

# If ran with sudo
if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

# Update your existing list of packages
apt-get update

# Install a few prerequisite packages
apt install -y -q apt-transport-https ca-certificates curl software-properties-common

# Add the GPG key for the official Docker repository to system
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

# Add the Docker repository to APT sources
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable"

# Update the package database with the Docker packages from the newly added repo.
apt-get update

# Finally install docker
apt-get install -y -q docker-ce

# For run docker command without sudo
usermod -aG docker ${USER}
# Or
# usermod -aG docker ${USER}
# To confirm
# id -nG

# To check if docker daemon and the prossess is enabled
# sudo systemctl status docker

# Make sure you are about to install from the Docker repo instead of the default Ubuntu repo
# apt-cache policy docker-ce

# Install docker-compose of related release
curl -L https://github.com/docker/compose/releases/download/1.24.1/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose

# Set the permissions.
chmod +x /usr/local/bin/docker-compose

# Check if installation was successful.
# docker-compose --version


    # sudo apt-get remove docker-compose
    # sudo curl -L "https://github.com/docker/compose/releases/download/1.23.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
    # sudo chmod +x /usr/local/bin/docker-compose
    # sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose

