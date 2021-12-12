#!/bin/bash

# Find and print names of all soft-links on your VM; 
sudo find / -type l -ls >> ~/softlinks.txt

# Find and print count of block and character devices;
sudo find / -type b -or -type c | wc -l >> ~/block_character_count.txt

# Find all folders with Sticky bit;
sudo find / -type d -perm -1000 -ls >> ~/sticky_bit.txt

# Make soft link for /etc/hostname in /tmp folder
sudo ln -s /etc/hostname /tmp/hostname

# Create user “testuser”
sudo useradd testuser

# Create file in home directory “testuser_data” owned by “testuser”
sudo touch /home/testuser/testuser_data
chown testuser:testuser /home/testuser/testuser_data
