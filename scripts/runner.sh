#!/bin/bash

# Create a folder
mkdir actions-runner && cd actions-runner 
# Download the latest runner package
curl -o actions-runner-linux-x64-2.304.0.tar.gz -L https://github.com/actions/runner/releases/download/v2.304.0/actions-runner-linux-x64-2.304.0.tar.gz 
# Optional: Validate the hash
echo "292e8770bdeafca135c2c06cd5426f9dda49a775568f45fcc25cc2b576afc12f  actions-runner-linux-x64-2.304.0.tar.gz" | shasum -a 256 -c 
# Extract the installer
tar xzf ./actions-runner-linux-x64-2.304.0.tar.gz

./config.sh --url https://github.com/UrbanOS-Public/sky_blue --token 

#Run it!
./run.sh
# or
# Stop the self-hosted runner application if it is currently running.
# Install the service with the following command:
sudo ./svc.sh install
#Alternatively, the command takes an optional user argument to install the service as a different user.
./svc.sh install USERNAME

#Start the service with the following command:
sudo ./svc.sh start

#Check the status of the service with the following command:
sudo ./svc.sh status
#For more information on viewing the status of your self-hosted runner, see "Monitoring and troubleshooting self-hosted runners."

#Stop the service with the following command:
# sudo ./svc.sh stop

#Uninstalling the service
#Stop the service if it is currently running.
#Uninstall the service with the following command:
# sudo ./svc.sh uninstall


# Using your self-hosted runner
# Use this YAML in your workflow file for each job
# runs-on: self-hosted

#sudo apt install docker.io
#curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash
#sudo chmod 666 /var/run/docker.sock
#sudo apt-get install unzip
#sudo apt-get install zip
#sudo apt install nodejs
#

# sh -c "$(curl -fsSL https://gist.githubusercontent.com/gjgd/5a08da85a98bf147294f331461e44d1f/raw/a63bf0f4169a8ab651adfa0a56e676e6bc465876/setup-github-action-runner.sh)"

# Update instance
sudo apt update -y
sudo apt upgrade -y

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