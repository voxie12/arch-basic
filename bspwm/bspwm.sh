#!/bin/bash

set -e

sudo pacman -S --noconfirm --needed xorg 
sudo pacman -S --noconfirm --needed xorg-xinit
sudo pacman -S --noconfirm --needed bspwm
sudo pacman -S --noconfirm --needed sxhkd
sudo pacman -S --noconfirm --needed alacritty
sudo pacman -S --noconfirm --needed nnn

install -Dm755 /usr/share/doc/bspwm/examples/bspwmrc ~/.config/bspwm/bspwmrc
install -Dm644 /usr/share/doc/bspwm/examples/sxhkdrc ~/.config/sxhkd/sxhkdrc

touch $HOME/.xinitrc
echo "exec bspwm" >> $HOME/.xinitrc

echo "---"
echo "bspwm is installed and be sure to change your terminal in .config/sxhkdrc"
echo "---"
