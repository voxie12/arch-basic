#!/bin/sh

doas pacman -S --noconfirm --needed zsh
doas pacman -S --noconfirm --needed zsh-completions
doas pacman -S --noconfirm --needed zsh-syntax-highlighting

touch $HOME/.zshrc

chsh $USER -s $(which zsh)

echo "####################################"
echo "######### zsh is installed #########"
echo "####################################"
