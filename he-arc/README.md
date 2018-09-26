# Accès au VPN de la HE-ARC
## Installation d'openconnect
### Archlinux
```sh
sudo pacman -S openconnect openvpn inotify-tools
```
### Debian
```sh
sudo apt install openconnect openvpn inotify-tools
```

## Création du tunnel
```sh
sudo openvpn --mktun --dev tun0
sudo ip link set dev tun0 up
```

## Création du répertoire de montage
```sh
mkdir ~/HE-ARC
mkdir ~/HE-ARC/ING
mkdir ~/HE-ARC/common
```

## Enregistrement des logins
Créer les fichiers avec l'utilisateur courant (sans sudo).

Remplacer `<username-hearc>` et `<password-hearc>` par vos logins de la HE-ARC.
### ~/.credentials
```sh
user=<username-hearc>
password=<password-hearc>
```

### ~/.credentials_cisco
```sh
<username-hearc>
<password-hearc>
```

## Définir les droits des fichiers de credential
```sh
sudo chmod 600 ~/.credentials ~/.credentials_cisco
```

## Création des scripts
### ~/connect-he-arc.sh
Pour monter les partages depuis un réseau HE-ARC (dans l'école).

```sh
#!/bin/sh
sudo mount -o vers=2.1,uid=1000,credentials=$HOME/.credentials -t cifs //SRV-FS11.intra.eiaj.ch/ORGINGFormation$ $HOME/HE-ARC/ING
sudo mount -o vers=2.1,uid=1000,credentials=$HOME/.credentials -t cifs //srv-fs1.intra.eiaj.ch/ORGHE-ARCCommon $HOME/HE-ARC/common
echo "Press any key to disconnect"
read -s
until sudo umount -f $HOME/HE-ARC/ING
do
	echo "try again"
done
until sudo umount -f $HOME/HE-ARC/common
do
	echo "try again"
done
```

### ~/vpnconnect-he-arc.sh
Pour monter les partages depuis l'extérieur.

```sh
#!/bin/sh
sudo < ~/.credentials_cisco openconnect webvpn.he-arc.ch -g anyexterne -b
until grep -q "domain intra.eiaj.ch" /etc/resolv.conf > /dev/null 2>&1 ; do inotifywait -e modify /etc/resolv.conf ; done #Source : https://stackoverflow.com/questions/25959870/how-to-wait-till-a-particular-line-appears-in-a-file
echo "search intra.eiaj.ch" | sudo tee -a /etc/resolv.conf
sh connect-he-arc.sh
sudo pkill -SIGINT openconnect
sleep 2
clear
```

## Rendre les scripts exécutables
```sh
sudo chmod a+x vpnconnect-he-arc.sh connect-he-arc.sh
```

> [Liste des partages](https://faq.he-arc.ch/dfs/dfsORG.html)