#!/bin/bash

# Create folders
mkdir /vagrant/folder1 /vagrant/folder2

# Install service
mv /vagrant/move-files.service /etc/systemd/system/move-files.service
 
# Reload systemd daemon
systemctl daemon-reload

# Enable move-files service and start it right away
systemctl enable move-files.service --now

# Add crontab job to log users
sudo /bin/bash -c 'echo "* * * * 1-5 root who>>/var/log/logged-in.log" >> /etc/crontab'
