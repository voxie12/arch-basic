#!/bin/bash

ln -sf /usr/share/zoneinfo/Europe/London /etc/localtime
hwclock --systohc
sed -i '160s/.//' /etc/locale.gen
#sed -i '/en_GB.UTF-8 UTF-8/s/^#//g' /etc/locale.gen
locale-gen
echo "LANG=en_GB.UTF-8" >> /etc/locale.conf
echo "KEYMAP=uk" >> /etc/vconsole.conf
echo "arch" >> /etc/hostname
echo "127.0.0.1 localhost" >> /etc/hosts
echo "::1       localhost" >> /etc/hosts
echo "127.0.1.1 arch.localdomain arch" >> /etc/hosts
echo root:jay | chpasswd

# pacman -S --noconfirm grub efibootmgr networkmanager network-manager-applet dialog wpa_supplicant mtools dosfstools reflector base-devel linux-headers avahi xdg-user-dirs xdg-utils gvfs gvfs-smb nfs-utils inetutils dnsutils bluez bluez-utils cups hplip alsa-utils pulseaudio bash-completion openssh rsync reflector acpi acpi_call tlp virt-manager qemu qemu-arch-extra ovmf bridge-utils dnsmasq vde2 openbsd-netcat ebtables iptables ipset firewalld flatpak sof-firmware nss-mdns acpid

pacman -S --noconfirm --needed grub networkmanager base-devel linux-headers openssh
#pacman -S --noconfirm  virt-manager qemu qemu-arch-extra ovmf bridge-utils dnsmasq vd2 openbsd-netcat ebtables iptables ipset 

# pacman -S --noconfirm acpi acpi_call network-manager-applet # for laptop

#pacman -S --noconfirm --needed xf86-video-intel
# pacman -S --noconfirm xf86-video-amdgpu
# pacman -S --noconfirm nvidia nvidia-utils nvidia-settings

grub-install --recheck /dev/sda
grub-mkconfig -o /boot/grub/grub.cfg

systemctl enable NetworkManager
# systemctl enable bluetooth
# systemctl enable cups
systemctl enable sshd
# systemctl enable avahi-daemon
# systemctl enable tlp
# systemctl enable reflector.timer
#systemctl enable fstrim.timer
#systemctl enable libvirtd
# systemctl enable firewalld
# systemctl enable acpid

useradd -mG wheel jay
echo jay:jay | chpasswd

/bin/echo -e "\e[1;32mDone! Type exit, umount -a and reboot.\e[0m"
