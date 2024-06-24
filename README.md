# Prepare Server

This repository contains a set of scripts designed to facilitate the repetitive installation and configuration of Docker, Docker Compose, Nginx, and Certbot on Ubuntu servers. These scripts automate the installation of necessary software and help configure Nginx as a proxy for Docker containers. The scripts are intended to be used on Ubuntu 22 and higher.

## Prerequisites

Before using these scripts, ensure that you have:
- An Ubuntu 22 (or higher) server.
- A domain name with an A record set up in DNS pointing to your server's IP address (if using Nginx as a proxy).

## Scripts

1. [install_docker.sh](#install_dockersh)
2. [install_nginx.sh](#install_nginxsh)
3. [add_proxy.sh](#add_proxysh)

### install_docker.sh

This script installs Docker, Docker Compose, and adds the current user to the Docker group.

#### Instructions:

1. Clone this repository:
   ```sh
   git clone https://github.com/CloudLab-Studio/prepare-server.git
   cd prepare-server
   ```

2. Make the script executable:
   ```sh
   chmod +x install_docker.sh
   ```

3. Run the script:
   ```sh
   ./install_docker.sh
   ```

#### Script Details:

- Installs Docker using the official Docker installation script.
- Adds the current user to the Docker group to allow running Docker commands without `sudo`.
- Installs Docker Compose.
- Verifies the installation by printing the versions of Docker and Docker Compose.

### install_nginx.sh

This script installs Nginx, Certbot, and configures the firewall to allow HTTP and HTTPS traffic.

#### Instructions:

1. Make the script executable:
   ```sh
   chmod +x install_nginx.sh
   ```

2. Run the script with the desired Nginx version:
   ```sh
   ./install_nginx.sh [stable|mainline]
   ```

#### Script Details:

- Ensures the script is running on Ubuntu.
- Installs the selected version of Nginx (stable or mainline) using the PPA.
- Installs and configures Certbot for SSL certificates.
- Opens ports 80 and 443 in the firewall.
- Restarts Nginx to apply changes.

### add_proxy.sh

This script sets up an Nginx proxy configuration for a specified domain and port, and obtains an SSL certificate using Certbot.

#### Instructions:

1. Make the script executable:
   ```sh
   chmod +x add_proxy.sh
   ```

2. Run the script and follow the prompts:
   ```sh
   ./add_proxy.sh
   ```

3. You will be prompted to enter:
   - The domain name.
   - The port number to proxy.
   - Your email address for the SSL certificate.

#### Script Details:

- Prompts for the domain name, port number, and email address.
- Generates an Nginx configuration file for the specified domain and port.
- Restarts Nginx to apply the new configuration.
- Uses Certbot to obtain an SSL certificate and configure Nginx for HTTPS.

## Notes

- These scripts are designed to work only on Ubuntu 22 and higher.
- Ensure that your domain's A record is correctly set up in DNS before running `add_proxy.sh`.

## Conclusion

By using these scripts, you can easily and quickly set up Docker, Docker Compose, Nginx, and Certbot on your Ubuntu server, and configure Nginx as a proxy for your Docker containers. This automation helps streamline the process and reduces the potential for errors during manual setup.