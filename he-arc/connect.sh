#!/bin/sh
sudo mount -o vers=3.0,uid=1000,credentials=$HOME/.credentials -t cifs //SRV-FS11.intra.eiaj.ch/ORGINGFormation$ $HOME/HE-ARC/ING
sudo mount -o vers=3.0,uid=1000,credentials=$HOME/.credentials -t cifs //srv-fs1.intra.eiaj.ch/ORGHE-ARCCommon $HOME/HE-ARC/common
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