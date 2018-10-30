#!/bin/sh
echo enter your computer name : 
read computername
echo enter the root password
passwd #Enter the password that you want
echo enter your username :
read username
useradd -m -g users $username
echo enter the password for your account
passwd $username # Enter the password for your account

pacman --needed --noconfirm -Syy
pacman --needed --noconfirm -Su
pacman --needed --noconfirm -S sudo
pacman --needed --noconfirm -S netctl
pacman --needed --noconfirm -S dialog
pacman --needed --noconfirm -S wpa_supplicant
pacman --needed --noconfirm -S networkmanager
pacman --needed --noconfirm -S network-manager-applet
pacman --needed --noconfirm -S pulseaudio
pacman --needed --noconfirm -S pavucontrol
pacman --needed --noconfirm -S fuse
pacman --needed --noconfirm -S git
pacman --needed --noconfirm -S xf86-input-libinput
pacman --needed --noconfirm -S playerctl
pacman --needed --noconfirm -S xclip
pacman --needed --noconfirm -S maim
pacman --needed --noconfirm -S feh
pacman --needed --noconfirm -S compton
pacman --needed --noconfirm -S lxappearance
pacman --needed --noconfirm -S rofi
pacman --needed --noconfirm -S i3
pacman --needed --noconfirm -S i3-gaps
pacman --needed --noconfirm -S base-devel
pacman --needed --noconfirm -S curl
pacman --needed --noconfirm -S wget
pacman --needed --noconfirm -S zsh
pacman --needed --noconfirm -S tilix # alternative to terminator
pacman --needed --noconfirm -S nemo # alternative to dolphin, solve the progress bar issue
pacman --needed --noconfirm -S nemo-fileroller
pacman --needed --noconfirm -S nemo-preview
pacman --needed --noconfirm -S nemo-seahorse
pacman --needed --noconfirm -S nemo-share
pacman --needed --noconfirm -S nemo-terminal
pacman --needed --noconfirm -S firefox
pacman --needed --noconfirm -S libreoffice
pacman --needed --noconfirm -S gimp
pacman --needed --noconfirm -S ranger # terminal based file browser
pacman --needed --noconfirm -S vim
pacman --needed --noconfirm -S zsh-autosuggestions
pacman --needed --noconfirm -S zsh-syntax-highlighting
pacman --needed --noconfirm -S vlc
pacman --needed --noconfirm -S scrot
pacman --needed --noconfirm -S imagemagick
pacman --needed --noconfirm -S xautolock
pacman --needed --noconfirm -S ark
pacman --needed --noconfirm -S unzip
pacman --needed --noconfirm -S unrar
pacman --needed --noconfirm -S lxqt-policykit
pacman --needed --noconfirm -S htop
pacman --needed --noconfirm -S gparted
pacman --needed --noconfirm -S xfce4-notifyd
pacman --needed --noconfirm -S xfce4-power-manager
pacman --needed --noconfirm -S cups
pacman --needed --noconfirm -S cups-pdf
pacman --needed --noconfirm -S print-manager
pacman --needed --noconfirm -S system-config-printer
pacman --needed --noconfirm -S hplip
pacman --needed --noconfirm -S eog
pacman --needed --noconfirm -S deluge
pacman --needed --noconfirm -S breeze
pacman --needed --noconfirm -S breeze-gtk
pacman --needed --noconfirm -S breeze-icons
pacman --needed --noconfirm -S qt5ct
pacman --needed --noconfirm -S grub
pacman --needed --noconfirm -S os-prober
pacman --needed --noconfirm -S efibootmgr
pacman --needed --noconfirm -S dosfstools
pacman --needed --noconfirm -S mtools
pacman --needed --noconfirm -S xorg-server
pacman --needed --noconfirm -S xorg-xinit
pacman --needed --noconfirm -S xorg-xrandr
pacman --needed --noconfirm -S xf86-video-intel
pacman --needed --noconfirm -S lightdm
pacman --needed --noconfirm -S lightdm-gtk-greeter
pacman --needed --noconfirm -S python-pip
pacman --needed --noconfirm -S jdk8-openjdk
pacman --needed --noconfirm -S deepin-calendar
pacman --needed --noconfirm -S gnome-calculator
pacman --needed --noconfirm -S avahi
pacman --needed --noconfirm -S konsole # terminal IN dolphin
pacman --needed --noconfirm -S exfat-utils
pacman --needed --noconfirm -S chromium
pacman --needed --noconfirm -S ttf-croscore
pacman --needed --noconfirm -S openssh
pacman --needed --noconfirm -S openconnect # you might not need this
pacman --needed --noconfirm -S openvpn # you might not need this
pacman --needed --noconfirm -S inotify-tools
pacman --needed --noconfirm -S cifs-utils
pacman --needed --noconfirm -S gnome-themes-standard
pacman --needed --noconfirm -S wireshark-qt
pacman --needed --noconfirm -S pinta
pacman --needed --noconfirm -S numlockx
pacman --needed --noconfirm -S autorandr
pacman --needed --noconfirm -S blueman
pacman --needed --noconfirm -S bluez
pacman --needed --noconfirm -S bluez-utils
pip install virtualenv

ln -sf /usr/share/zoneinfo/Europe/Zurich /etc/localtime # change this
hwclock --systohc

sed -i '/root ALL=(ALL) ALL/a '"$username"' ALL=(ALL) ALL' /etc/sudoers
sed -i "s/PKGEXT='.pkg.tar.xz'/PKGEXT='.pkg.tar'/g" /etc/makepkg.conf
sed -i '/#en_US.UTF-8 UTF-8/c\en_US.UTF-8 UTF-8' /etc/locale.gen
sed -i '/#fr_CH.UTF-8 UTF-8/c\fr_CH.UTF-8 UTF-8' /etc/locale.gen
locale-gen # Generate the locales

# change the second line and the last line
echo "LANG=en_US.UTF-8" > /etc/locale.conf
echo "LC_TIME=fr_CH.UTF-8" >> /etc/locale.conf 
echo "KEYMAP=fr_CH" > /etc/vconsole.conf
echo $computername > /etc/hostname
echo "127.0.0.1 	localhost" >> /etc/hosts
echo "::1			localhost" >> /etc/hosts
echo "127.0.1.1	 $computername.localdomain  $computername" >> /etc/hosts
echo "*	hard	nofile	10000" >> /etc/security/limits.conf
echo "DefaultLimitNOFILE=10000" >> /etc/systemd/system.conf
echo "fs.inotify.max_user_watches=524288" > /etc/sysctl.d/inotify.conf
echo "QT_QPA_PLATFORMTHEME=qt5ct" >> /etc/environment
echo "QT_AUTO_SCREEN_SCALE_FACTOR=0" >> /etc/environment
echo "blacklist pcspkr" > /etc/modprobe.d/nobeep.conf
echo "Server = http://mirror.puzzle.ch/archlinux/$repo/os/$arch" > /etc/pacman.d/mirrorlist

cp puleseaudio/default.conf /usr/share/puleseaudio/alsa-mixer/profile-sets/
cp libinput/40-libinput.conf /etc/X11/xorg.conf.d/
cp install_arch/login_wallpaper.jpg /usr/share/pixmaps/
cp install_arch/lightdm-gtk-greeter.conf /etc/lightdm/
cp script/i3lockc /usr/bin/
chmod a+x /usr/bin/i3lockc
systemctl enable lightdm
systemctl enable NetworkManager.service
systemctl enable avahi-daemon.service
systemctl enable org.cups.cupsd.service
systemctl enable bluetooth.service
grub-install --target=x86_64-efi --bootloader-id=grub_uefi
grub-mkconfig -o /boot/grub/grub.cfg

sudo -H -u $username bash -c 'sh install_arch/.install_light.sh' # Install aurman + oh my zsh et Co.
