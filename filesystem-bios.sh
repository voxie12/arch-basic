#!/bin/bash

loadkeys uk

timedatectl set-ntp true

pacman -Sy

pacstrap /mnt base linux linux-firmware vim git intel-ucode

genfstab -U /mnt >> /mnt/etc/fstab

arch-chroot /mnt 
