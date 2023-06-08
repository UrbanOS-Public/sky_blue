#!/bin/bash

# Update the system
sudo apt-get update -y

# Upgrade packages
sudo apt-get upgrade -y

# Install latest version of git
sudo add-apt-repository ppa:git-core/ppa -y
sudo apt-get update
sudo apt-get install git -y

# Install and setup docker
sudo apt install docker.io docker-compose -y
sudo systemctl enable docker
sudo gpasswd -a $USER docker
newgrp docker

# Add current user to sudoer file
# https://linuxize.com/post/how-to-add-user-to-sudoers-in-ubuntu/
echo "${USER}  ALL=(ALL) NOPASSWD:ALL" | sudo tee "/etc/sudoers.d/${USER}"