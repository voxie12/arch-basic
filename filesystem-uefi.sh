#!/bin/bash

loadkeys uk 

pacman -Sy

sgdisk -o /dev/mmcblk0
sgdisk -n 1:0:+500M -t 1:ef00 /dev/mmcblk0
sgdisk -n 2:0:0               /dev/mmcblk0

mkfs.vfat -F 32 /dev/mmcblk1
mkfs.ext4       /dev/sda2

mount /dev/sda2 /mnt
mkdir /mnt/boot/efi
mount /dev/sda1 /mnt/boot/efi

pacstrap /mnt base linux-lts linux-firmware vim git intel-ucode

genfstab -U /mnt >> /mnt/etc/fstab

arch-chroot /mnt 
