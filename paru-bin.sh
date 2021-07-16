#!/bin/sh

sudo pacman -S --noconfirm --needed git devel-base
git clone https://aur.archlinux.org/paru-bin.git
cd paru-bin
makepkg -si --noconfirm 

