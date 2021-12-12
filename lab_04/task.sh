#!/bin/bash

# Create user “adminuser”
sudo useradd adminuser

# Set password for “adminuser”
sudo echo 'adminuser:admin123' | sudo chpasswd

# Grant for “adminuser” sudoer permission
echo 'adminuser ALL=(ALL:ALL) ALL' >> /etc/sudoers    

# Create user “poweruser”
sudo useradd poweruser

# Grant for “poweruser” permission for iptables command
sudo echo 'poweruser ALL=(ALL:ALL) /usr/sbin/iptables' >> /etc/sudoers

# Allow “poweruser” to read home directory of “adminuser” 
sudo setfacl -R -m user:poweruser:r ~adminuser
sudo setfacl -d -R -m user:poweruser:r ~adminuser

# List all of files with SUID bit set  
sudo find / -type d -perm 4000 -ls >> ~/suid.txt