#!/bin/bash

sudo timedatectl set-ntp true
sudo hwclock --systohc

sudo reflector -c GB --verbose --latest 6 --sort rate --save /etc/pacman.d/mirrorlist

git clone https://aur.archlinux.org/pikaur.git
cd pikaur
makepkg -si --noconfirm

pikaur -S --noconfirm chaotic-keyring chaotic-mirrorlist

echo "[chaotic-aur]" >> /etc/pacman.conf
echo "Include = /etc/pacman.d/chaotic-mirrorlist" >> /etc/pacman.conf

sudo pacman -S --noconfirm paru

paru -S --noconfirm auto-cpufreq
sudo systemctl enable auto-cupfreq

paru -S --noconfirm --needed xorg xorg-xinit bspwm sxhkd chromium xwallpaper sxiv mpv rxvt-unicode pcmanfm fish neofetch lxappearance arc-gtk-theme arc-icon-theme archlinux-wallpaper lxsession

install -Dm755 /usr/share/doc/bspwm/examples/bspwmrc ~/.config/bspwm/bspwmrc
install -Dm644 /usr/share/doc/bspwm/examples/sxhkdrc ~/.config/sxhkd/sxhkdrc

echo "xset r rate 360 60" >> ~/.config/bspwm/bspwmrc
echo "xsetroot -cursor_name left_ptr" >> ~/.config/bspwm/bspwmrc
echo "xwallpaper --maximize /usr/share/backgrounds/archlinux/archwave.png" >> ~/.config/bspwm/bspwmrc
sed -i /urxvt/alacritty -e fish/
echo "startx" >> ~/.bash_profile

cp /etc/X11/xinit/xinitrc $HOME/.xinitrc
sed '51d;52d;53d;54d;55d' $HOME/.xinitrc


mkdir $HOME/.config/fish
touch $HOME/.config/fish/config.fish
echo "neofetch" >> $HOME/.config/fish/config.fish
echo "exec fish" >> .bashrc

sudo flatpak install -y spotify

/bin/echo -e "\e[1;32mREBOOTING IN 5..4..3..2..1..\e[0m"
sleep 5
reboot
