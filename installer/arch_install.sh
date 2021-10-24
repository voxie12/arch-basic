# == MY ARCH SETUP INSTALLER == #
#part1
pacman --noconfirm -Sy archlinux-keyring
loadkeys uk
timedatectl set-ntp true
lsblk
each "Enter the drive: "
read drive
fdisk $drive
echo "Enter the linux partition: "
read partition
mkfs.ext4 $partition
mount $partition /mnt
reflector --verbose -l 10 -c GB --sort rate --save /etc/pacman.d/mirrorlist
sed -i 's/^#Para/Para/' /etc/pacman.conf
pacstrap /mnt base base-devel linux linux-firmware intel-ucode git neovim
genfstab -U /mnt >> /mnt/etc/fstab
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
echo root:jay | chpasswd
pacman -S grub
grub-install --recheck $drive
#sed -i 's/GRUB_TIMEOUT=5/GRUB_TIMEOUT=0/g' /etc/default/grub
grub-mkconfig -o /boot/grub/grub.cfg
pacman -S --noconfirm xorg xorg-xinit noto-fonts noto-fonts-cjk sxiv mpv man-db xwallpaper youtube-dl unclutter papirus-icon-theme zsh git rsync reflector dunst networkmanager pipewire pipewire-pulse wget opendoas
systemctl enable NetworkManager
systemctl enable fstrim.timer
touch /etc/doas.conf
echo "permit nopass jay" >> /etc/doas.conf
chown -c root:root /etc/doas.conf
chmod -c 0400 /etc/doas.conf
ln -sfT dash /usr/bin/sh
useradd -m -G wheel -s /bin/zsh jay
echo "%wheel ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
echo jay:jay | chpasswd
touch /etc/sysctl.d/99-swappiness.conf
echo "vm.swappiness=10" >> /etc/sysctl.d/99-swappiness.conf
ai3_path=/home/jay/arch_install3.sh
sed '1,/^#part3$/d' arch_install2.sh > $ai3_path
chmod +x $ai3_path
su -c $ai3_path -s /bin/sh jay
exit

#part3
cd $HOME
cd /tmp
git clone https://aur.archlinux.org/paru-bin.git
cd paru-bin/;makepkg -si --noconfirm;cd
doas sed -i '17s/.//' /etc/paru.conf
doas sed -i '35s/.//' /etc/paru.conf
doas sed -i '38s/.//' /etc/paru.conf
paru -S --noconfirm brave-bin zramd
doas systemctl enable zramd
cd $home
mkdir suckless
cd suckless
repos=( "dmenu" "dwm" "slstatus" "st" "slock" )
for repo in ${repos[@]}
do
    git clone git://git.suckless.org/$repo
    cd $repo;make;sudo make install;cd ..
done
cd $HOME
mkdir -p ~/dl ~/vid ~/music ~/doc ~/code ~/pic/wallhaven
cd pic/wallhaven
wget https://w.wallhaven.cc/full/9m/wallhaven-9m96rd.jpg
cat > ~/.xinitrc << EOF
slstatus &
setxkbmap gb &
xwallpaper --maximize /home/jay/pic/wallhaven/wallhaven-9m96rd.jpg &
xset r rate 300 50 &
xset s off -dpms &
unclutter &
exec dwm > /dev/null 2>&1 
EOF
fi
cat > ~/.zprofile << EOF
export EDITOR="nvim"
export VISUAL="nvim"
export TERMINAL="st"
export BROWSER="brave"

export PATH=$PATH:$HOME/.local/bin

if [ -z "${DISPLAY}" ] && [ "${XDG_VTNR}" -eq 1 ]; then
  exec startx
fi
EOF
fi
exit
