#! /bin/bash

if [ "`id -u`" -eq 0 ]; then
  echo "Root user detected!"
  echo "Please run as a non-root user, then enter sudo credentials as needed!"
  exit 0
fi

# Remove old versions of Docker
sudo apt-get remove docker docker-engine docker.io containerd runc

sudo apt-get update

# Enable https package installation
sudo apt-get install \
  apt-transport-https \
  ca-certificates \
  curl \
  gnupg-agent \
  software-properties-common

# Get the GPG key from Docker
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add -

# Setup the docker stable repository
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/debian \
   $(lsb_release -cs) \
   stable"

sudo apt-get update

# Install docker-ce
sudo apt-get install docker-ce docker-ce-cli containerd.io

# Add current user to docker group
sudo usermod -aG docker $USER

# Activate the new group settings
newgrp docker

echo "Please verify successful installation of docker, and the docker group membership by running 'docker run hello-world'"
