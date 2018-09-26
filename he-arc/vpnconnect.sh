#!/bin/sh
sudo < ~/.credentials_cisco openconnect webvpn.he-arc.ch -g anyexterne -b
until grep -q "domain intra.eiaj.ch" /etc/resolv.conf > /dev/null 2>&1 ; do inotifywait -e modify /etc/resolv.conf ; done #Source : https://stackoverflow.com/questions/25959870/how-to-wait-till-a-particular-line-appears-in-a-file
echo "search intra.eiaj.ch" | sudo tee -a /etc/resolv.conf
sh connect-he-arc.sh
sudo pkill -SIGINT openconnect
sleep 2
clear