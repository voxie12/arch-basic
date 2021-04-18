#!/bin/sh

sudo pacman -S --noconfirm --needed git devel-base
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si --noconfirm 

