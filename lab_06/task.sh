#!/bin/bash

for d in b c d e
do
  echo $(parted /dev/sd$d --script -- mklabel msdos)
  echo $(parted /dev/sd$d --script -- mkpart primary ext4 0 100%)
done

# Install EPEL and LVM2
yum install epel-release -y 
yum install lvm2 -y

# Create Physical Volumes
pvcreate /dev/sdb1 /dev/sdc1 /dev/sdd1 /dev/sde1

# Create Volume Groups
vgcreate volume_group_1 /dev/sdb1 /dev/sdc1
vgcreate volume_group_2 /dev/sdd1 /dev/sde1

# For each Volume Group
for id in 1 2
do
    VG="volume_group_$id"
    LV="logical_volume_$id"

    # Create Logical Volume
    lvcreate -n $LV -l 100%FREE $VG

    # Create ext4 file system on top of Logical Volume
    mkfs.ext4 /dev/$VG/$LV

    # Create directory to mount volume
    mkdir /mnt/$LV

    # Mount volume
    mount /dev/$VG/$LV /mnt/$LV

    # Get UUID of Logical Volume
    UUID=$(blkid -s UUID -o value /dev/$VG/$LV)

    # Add Logical Volume into File System Table
    echo "UUID=$UUID /mnt/$LV   ext4    defaults 0 0" >> /etc/fstab
done

# Save the changes and mount the Logical Volumes (so we can use them without reboot)
mount -a