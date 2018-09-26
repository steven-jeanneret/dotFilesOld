# Introduction
This document will list the step to install arch linux with i3 and a lot of stuff like Polybar, rofi and other things to have a full usable desktop.

# Download and Burn ISO
Download the iso file on the [Download's page of the arch linux website](https://www.archlinux.org/download/).

Check the USB path and burn it
```sh
sudo fdisk -l #In my case it's /dev/sdb/
sudo dd bs=4M if=~/Download/archlinux-2018.07.01-x86_64.iso of=/dev/sdb
```

> Don't take the partition, take the path of the device (don't end with a number)

# Boot on the key
Just restart your computer and boot on the key, depend on your computer you have to press *F9*, *F10*, *delete* or something else.

# Set keyboard layout
```sh
ls /usr/share/kbd/keymaps/**/*.map.gz # List available keymap
loadkeys fr_CH #With your layout
```

# Connect to internet
If your use a wired connection, it should be fine, try to ping something, if it's good skip this point.
```sh
wifi-menu #Select your network and enter your password
sleep 3 # Wait ~3 seconds
ping 8.8.8.8 -c 4
```
If you can ping it's fine.

# Update the clock
```sh
timedatectl set-ntp true
```

# Partition the disk
The simplest way is to create partition before installation with Gparted. Else you can use [this](https://wiki.archlinux.org/index.php/partitioning)

You have to create a EFI partition and a partition for the root directory.

```sh
mkfs.ext4 /dev/sda2 # Format root partition
mount /dev/sda2 /mnt # Mount the partition
```

# Install the base system
```sh
pacstrap /mnt base
genfstab -U /mnt >> /mnt/etc/fstab
arch-chroot /mnt
```
Now if you do something it will affect your current installation.

# Script
From here, you can use a script (this is simply all the following commands) or continue.
If you want to do it manualy, just skip this point.

```sh
cd /tmp
pacman ---needed --noconfirm -S git
mkdir /boot/EFI
mount /dev/sda1 /boot/EFI #Replace with your EFI partition
mkdir /mnt/sda3 # Mount all partition that should figure in grub
mount /dev/sda3 /mnt/sda3
git clone https://github.com/steven-jeanneret/dotFiles.git
cd dotFiles
./install_arch/install.sh
# The script installed the intel graphics driver, if you need somethings else, you can remove it and install the one you need.
# The script define Zurich for the timezone, change it with your city : ln -sf /usr/share/zoneinfo/Europe/Zurich /etc/localetime
# The script put CH_fr for the terminal keyboard, edit it in : nano /etc/vconsole.conf
exit
umount -a
reboot
```

# Information
There are missing command in the manual way, you should look at all command in the script.

> I will update this when I will have time.

# Install some package
> All aren't required, it depend on your usage

```sh
pacman --needed --noconfirm -S sudo netctl dialog wpa_supplicant networkmanager network-manager-applet pulseaudio pavucontrol fuse git xf86-input-synaptics playerctl xclip maim light feh fonts-font-awesome systemsettings compton lxappearance qt5ct kde-config-gtk-style rofi i3 i3-gaps base-devel wget zsh terminator dolphin breeze breeze-gtk breeze-icon-theme firefox libreoffice gimp ranger vim zsh-autosuggestions zsh-syntax-highlighting vlc scrot imagemagick xautolock cups cups-manager print-manager system-config-printer hplip
```

# Set region
Just pick the one you need.

```sh
ln -sf /usr/share/zoneinfo/Europe/Zurich /etc/localetime
hwclock --systohc
```

# Set locales
Just uncomment all you need, I uncommented en_US.UTF-8 and fr_CH.UTF-8

```sh
sed -i '/#en_US.UTF-8 UTF-8/c\en_US.UTF-8 UTF-8' /etc/locale.gen
sed -i '/#fr_CH.UTF-8 UTF-8/c\fr_CH.UTF-8 UTF-8' /etc/locale.gen
locale-gen # Generate the locales
```

# Set language
```sh
echo LANG=en_US.UTF-8 > /etc/locale.conf
```

# Set keymap for console
```sh
echo KEYMAP=fr_CH > /etc/vconsole.conf
```

# Set computer name
```sh
computername = dellarch
echo $computername > /etc/hostname
echo 127.0.0.1 	localhost >> /etc/hosts
echo ::1			localhost >> /etc/hosts
echo 127.0.1.1	 $computername.localdomain  $computername >> /etc/hosts
```

# Set the password for root
```sh
passwd #Enter the password that you want
```

# Create your user
Replace username with your name
```sh
username = steven
useradd -m -g users -s /usr/bin/zsh $username
passwd username # Enter the password for your account
```

# Add your account to the sudo group
Search (*ctrl + w*) `(ALL)` and duplicate the line for your users
```sh
sed -i '/root ALL=(ALL) ALL/a '"$username"' ALL=(ALL)' /etc/sudoers
```

I added `steven ALL=(ALL) ALL` to the file.

# Add the graphics parts
Replace xf86-video-intel with the driver that you want, you can find it [here](https://wiki.archlinux.org/index.php/xorg#Driver_installation)
```sh
pacman -S xorg-server xorg-xinit xf86-video-intel lightdm lightdm-gtk-greeter
systemctl enable lightdm
systemctl enable NetworkManager.service
```

# Install bootloader
```sh
pacman -S grub os-prober efibootmgr dosfstools mtools
mkdir /boot/EFI
mount /dev/sda1 /boot/EFI #Replace with your EFI partition
grub-install --target=x86_64-efi --bootloader-id=grub_uefi --recheck
grub-mkconfig -o /boot/grub/grub.cfg
```

# Set max number of open file
```sh
echo "*	hard	nofile	10000" >> /etc/security/limits.conf
echo DefaultLimitNOFILE=10000 >> /etc/systemd/system.conf
```

# Install aurman (AUR)
```sh
gpg --list-keys
git clone https://aur.archlinux.org/aurman.git
cd aurman
gpg --recv-key $(sed -n -e '/validpgpkeys=/ s/.*\= *//p' PKGBUILD | cut -d "'" -f2 | cut -d "'" -f1)
makepkg -si
```

# Install vs-code and light
```sh
aurman --needed --noconfirm --noedit -S code light
ln -s /usr/bin/code-oss /usr/bin/code
```

# Install oh my zsh and spaceship theme
```sh
sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)" #oh my zsh
git clone https://github.com/denysdovhan/spaceship-prompt.git "$ZSH_CUSTOM/themes/spaceship-prompt"
ln -s "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme"
```

# Reboot and eject partition
```sh
exit
umount -a
reboot
```

set gtk theme in lxappearance
set kde theme in qt5 settings


# Sources
[Installation guide on the wiki of archlinux](https://wiki.archlinux.org/index.php/installation_guide)