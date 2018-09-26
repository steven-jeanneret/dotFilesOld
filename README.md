# Introduction

![Image](https://i.imgur.com/blS2tyf.jpg)

Here are my dotFiles for my archlinux setup with i3, polybar, zsh, terminator and the Xressources.

If you are interested for the full installation (archlinux and a lot of software), take a look in the [install_arch subfolder](https://github.com/steven-jeanneret/dotFiles/tree/master/install_arch)

# Download
```sh
git clone https://github.com/steven-jeanneret/dotFiles.git
cd dotFiles
```
# Backup your config
If you want to backup your config file before trying this.

```sh
mkdir backup_config
cp mngDotFiles.sh backup_config/
cp data backup_config/
cd backup_config
./mngDotFiles.sh
cd ..
```

# Installation
## Default
If your app use the default path, you can use the script with the default settings.
```sh
./mngDotFiles.sh import
```

## Manual
If you use custom path, you can copy files manualy but take care, zshrc become .zshrc and Xressources become .Xressources.
Or you can simply edit the *data* file.
Change the first column, with your path, then you can use the script.

```sh
nano data
./mngDotFiles.sh import
```

# Restore your config
```sh
cd backup_config
./mngDotFiles.sh import
```

# App used
List of all app that I used for the interface :
 * zsh
 * i3
 * i3-gaps
 * polybar
 * rofi # Launcher
 * xautolock # Lock after x minutes
 * [lock.sh script](https://www.reddit.com/r/unixporn/comments/3358vu/i3lock_unixpornworthy_lock_screen/)
	* scrot
	* imagemagick 
 * xf86-input-synaptics # Manage trackpad
 * lxqt-policykit # Ask password for mounting disk
 * networkmanager # Wifi in tray
 * pasystray # Sound in tray
 * compton # Add transparency support
 * feh # Background
 * maim # Print screen
 * xclip # Copy the screen to clipboard
 * light # Manager display light
 * playerctl # Manage music
 * pactl # Manage volume

## Some other apps
 * terminator # Terminal
 * dolphin # File manager
 * ranger # Fast file manager with vim shortcut
 * google chrome # Web browser
 * code # Editor