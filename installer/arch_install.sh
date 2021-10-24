# == MY ARCH SETUP INSTALLER == #
#part1
echo "Welcome to Arch Linux Magic Script"
loadkeys us
timedatectl set-ntp true
lsblk
echo "Enter the drive: "
read drive
fdisk $drive
echo "Enter the linux partition: "
read partition
mkfs.ext4 $partition
mount $partition /mnt
sed -i 's/^#Para/Para/' /etc/pacman.conf
pacstrap /mnt base base-devel linux linux-firmware intel-ucode git neovim
genfstab -U /mnt >> /mnt/etc/fstab
reflector -l 10 -c GB --sort rate --save /etc/pacman.d/mirrorlist
mv /etc/pacman.d/mirrorlist /mnt/etc/pacman.d/mirrorlist
sed '1,/^#part2$/d' arch_install.sh > /mnt/arch_install2.sh
chmod +x /mnt/arch_install2.sh
arch-chroot /mnt ./arch_install2.sh
exit

#part2
ln -sf /usr/share/zoneinfo/Europe/London /etc/localtime
hwclock --systohc
echo "en_GB.UTF-8 UTF-8" >> /etc/locale.gen
locale-gen
echo "LANG=en_GB.UTF-8" > /etc/locale.conf
echo "KEYMAP=uk" > /etc/vconsole.conf
echo "Hostname: "
read hostname
echo $hostname > /etc/hostname
echo "127.0.0.1       localhost" >> /etc/hosts
echo "::1             localhost" >> /etc/hosts
echo "127.0.1.1       $hostname.localdomain $hostname" >> /etc/hosts
passwd
pacman --noconfirm -S grub
grub-install --recheck $drive
sed -i 's/GRUB_TIMEOUT=5/GRUB_TIMEOUT=0/g' /etc/default/grub
grub-mkconfig -o /boot/grub/grub.cfg
sed -i 's/^#Para/Para/' /etc/pacman.conf
pacman -S --noconfirm xorg xorg-xinit noto-fonts noto-fonts-cjk sxiv mpv man-db xwallpaper \
  youtube-dl unclutter pipirus-icon-theme zsh git rsync reflector dunst networkmanager pipewire pipewire-pulse wget opendoas
systemctl enable NetworkManager
systemctl enable fstrim.timer
rm /bin/sh
ln -s dash /bin/sh
echo "%wheel ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
echo "Enter Username: "
username=jay
useradd -mG wheel -s /bin/zsh $username
passwd $username
echo "Pre-Installation Finish Reboot now"
ai3_path=/home/$username/arch_install3.sh
sed '1,/^#part3$/d' arch_install2.sh > $ai3_path
chown $username:$username $ai3_path
chmod +x $ai3_path
su -c $ai3_path -s /bin/sh $username
exit

#part3
cd $HOME
git clone https://github.com/voxie12/suckless.git
cd suckless
cd dmenu
sudo make clean install
cd ..
cd dwm
sudo make clean install
cd ..
cd slock
sudo make clean install
cd ..
cd slstatus
sudo make clean install
cd ..
cd st
sudo make clean install
cd ..
touch
cd $HOME
mkdir .dwm
touch .dwm/autostart
echo "slstatus &" >> .dwm/autostart
echo "xwallpaper --maximize /home/jay/pic/wallhaven/wallhaven-k7l81m.jpg &" >> .dwm/autostart
echo "xset r rate 250 50 &" >> .dwm/autostart
echo "xset s off -dpms &" >> .dwm/autostart
mkdir -p ~/dl ~/vid ~/music ~/doc ~/pic/wallhaven ~/code ~/git
cd pic/wallhaven
wget -c "https://w.wallhaven.cc/full/k7/wallhaven-k7l81m.jpg"
cd $HOME/git
git clone https://aur.archlinux.org/paru-bin.git
cd paru-bin
makepkg -si --noconfirm
cd $HOME
paru -S --noconfirm zramd nerd-fonts-mononoki brave-bin
sudo systemctl zramd
sudo touch /etc/sysctl.d/99-swappiness.conf
sudo echo "vm.swappiness=10" >> /etc/sysctl.d/99-swappiness.conf
exit
