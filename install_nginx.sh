#!/bin/bash

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
