#!/bin/bash

loadkeys uk 

pacman -Sy

echo 'label: dos' | sfdisk /dev/sda 
sgdisk -n 1:0:0 /dev/sda

mkfs.ext4       /dev/sda1

mount /dev/sda1 /mnt

pacstrap /mnt base linux linux-firmware vim git intel-ucode

genfstab -U /mnt >> /mnt/etc/fstab

arch-chroot /mnt 
