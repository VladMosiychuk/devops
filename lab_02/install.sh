#!/bin/bash

# Website content folder
CONTENT_FOLDER="/var/www/default/"

# Update system packages
sudo yum update -y

# Install EPEL and NGINX
sudo yum install epel-release -y 
sudo yum install nginx -y

# Copy nginx.config 
sudo cp /vagrant/nginx.conf /etc/nginx/nginx.conf

# Create content folder and copy index.html inside of it
sudo mkdir -p $CONTENT_FOLDER && cp /vagrant/index.html $CONTENT_FOLDER

# Make sure files in content folder cannot be written to or modified by httpd or other processes.
sudo chcon -Rt httpd_sys_content_t $CONTENT_FOLDER

# Enable and Start NGINX service right away
sudo systemctl enable nginx --now
