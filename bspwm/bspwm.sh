#!/bin/bash

install -Dm755 /usr/share/doc/bspwm/examples/bspwmrc ~/.config/bspwm/bspwmrc
install -Dm644 /usr/share/doc/bspwm/examples/sxhkdrc ~/.config/sxhkd/sxhkdrc

echo "---"
echo "bspwm is installed and be sure to change your terminal in .config/sxhkdrc"
echo "---"
