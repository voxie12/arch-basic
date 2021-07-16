#!/bin/bash

set -e

sudo pacman -S --noconfirm --needed opendoas

sudo touch /etc/doas.conf

echo "permit nopass jay" >> /etc/doas.conf

echo "#####################################"
echo "######### doas is installed #########"
echo "#####################################"
