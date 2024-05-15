#!/bin/bash

# Check if the script is running on Ubuntu
if [ "$(uname -s)" != "Linux" ] || [ "$(lsb_release -si)" != "Ubuntu" ]; then
    echo "This script is intended to run on Ubuntu only."
    exit 1
fi

# Function to display usage information
usage() {
    echo "Usage: $0 [stable|mainline]"
    exit 1
}

# Check if the script is run with an argument
if [ $# -ne 1 ]; then
    usage
fi

# Determine which version to install: stable or mainline
VERSION=$1
if [ "$VERSION" == "stable" ]; then
    PPA="ppa:ondrej/nginx"
elif [ "$VERSION" == "mainline" ]; then
    PPA="ppa:ondrej/nginx-mainline"
else
    usage
fi

# Update package list and install prerequisites
sudo apt update
sudo apt install -y software-properties-common wget

# Add the appropriate PPA
sudo add-apt-repository -y $PPA

# Refresh package list
sudo apt update

# Install Nginx
sudo apt install -y nginx-full

# Start and enable Nginx service
sudo systemctl start nginx
sudo systemctl enable nginx

# Print the status of Nginx
sudo systemctl status nginx

echo "Nginx installation completed successfully."

# Check if snapd is installed, if not install it
if ! command -v snap >/dev/null; then
    sudo apt install -y snapd
    echo "Snapd installed successfully."
fi

sudo snap install core; sudo snap refresh core

sudo apt remove certbot

sudo snap install --classic certbot

sudo ln -s /snap/bin/certbot /usr/bin/certbot

sudo service nginx restart

echo "Certbot installed successfully."