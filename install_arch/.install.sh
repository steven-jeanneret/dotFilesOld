#!/bin/sh
cd /tmp/
gpg --full-gen-key
gpg --list-keys
git clone https://aur.archlinux.org/aurman.git
cd aurman
gpg --recv-key $(sed -n -e '/validpgpkeys=/ s/.*\= *//p' PKGBUILD | cut -d "'" -f2 | cut -d "'" -f1)
makepkg -si
aurman --needed --noconfirm --noedit -S light
aurman --needed --noconfirm --noedit -S polybar
aurman --needed --noconfirm --noedit -S visual-studio-code-bin
aurman --needed --noconfirm --noedit -S intellij-idea-ultimate-edition
aurman --needed --noconfirm --noedit -S clion
aurman --needed --noconfirm --noedit -S phpstorm
aurman --needed --noconfirm --noedit -S webstorm
aurman --needed --noconfirm --noedit -S pycharm-professional
aurman --needed --noconfirm --noedit -S sublime-text-dev
aurman --needed --noconfirm --noedit -S pasystrayasy
aurman --needed --noconfirm --noedit -S slack-desktop
aurman --needed --noconfirm --noedit -S spotify
sudo ln -s /usr/bin/subl3 /usr/bin/subl
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh | sed 's:env zsh::g' | sed 's:chsh -s .*$::g')"
ZSH_CUSTOM=~/.oh-my-zsh/custom
git clone https://github.com/denysdovhan/spaceship-prompt.git "$ZSH_CUSTOM/themes/spaceship-prompt"
ln -s "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme"
cd /tmp/dotFiles
sh mngDotF.sh import
cd /tmp/
git clone https://github.com/steven-jeanneret/fonts.git && cd fonts && sh install_font.sh
echo "it's done, maybe you have to adjust the graphics driver, timezone or keyboard"
echo "Enter password to confirm changing default shell to zsh"
chsh -s /bin/zsh $username