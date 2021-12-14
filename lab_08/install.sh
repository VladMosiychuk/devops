#!/bin/bash

# Wesite content & httpd configuration folders
CONTENT_FOLDER="/var/www/localhost/"
HTTPD_CONF_PATH="/etc/httpd/conf.d/"

# Create content folder and copy index.html inside of it
sudo mkdir -p $CONTENT_FOLDER && sudo cp /vagrant/index.html $CONTENT_FOLDER

# Create httpd configuration folder and copy localhost.conf inside of it
sudo mkdir -p $HTTPD_CONF_PATH && sudo cp /vagrant/localhost.conf $HTTPD_CONF_PATH

# Make sure files in content folder cannot be written to or modified by httpd or other processes.
chcon -Rt httpd_sys_content_t $CONTENT_FOLDER

# Generate certificate for HTTPS
sudo openssl req \
    -x509 \
    -nodes \
    -days 365 \
    -newkey rsa:2048 \
    -keyout /etc/ssl/certs/apache.key \
    -out /etc/ssl/certs/apache.crt \
    -subj "/C=UA/CN=localhost/L=Lviv/O=ITSU"

# Install EPEL, HTTPD and MOD_SSL
sudo yum install epel-release -y
sudo yum install httpd mod_ssl -y

# Make sure httpd configuration is valid
sudo httpd -t

# Enable and Start HTTPD service right away
sudo systemctl enable httpd --now
