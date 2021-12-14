#!/bin/bash

# User         : root
# Host         : yoko.ukrtux.com
# Bind Port    : 1080
# Remote Port  : 4222
# Local Port   : 14222

### Seting everyting up

# Generate Authentication Key. I don't use passphrase beacause I'm too lazy to enter it =)
ssh-keygen -f /home/vlad/.ssh/id_ukrtux -N ""

# Use locally available key to authorise logins on a remote machine
ssh-copy-id -i /home/vlad/.ssh/id_ukrtux -p 4222 root@yoko.ukrtux.com

# Verify connection using key works (you'll need to enter password only first time)
ssh -i /home/vlad/.ssh/id_ukrtux -p 4222 root@yoko.ukrtux.com

# [FOR REVERSE] Permit root login and enable password authentication
# Edit: /etc/ssh/sshd_config
# ----> PermitRootLogin yes
# ----> PasswordAuthentication yes

#### Start Proxy
ssh -i /home/vlad/.ssh/id_ukrtux -D 1080 -p 4222 root@yoko.ukrtux.com

### Reverse proxy

# Start reverse proxy
ssh -i /home/vlad/.ssh/id_ukrtux -p 4222 -R 14222:localhost:22 root@yoko.ukrtux.com

# Connect to reverse proxy 
ssh -p 14222 vlad@yoko.ukrtux.com