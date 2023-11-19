#!/bin/bash

#Check for sudo privileges
if [[ $EUID -eq 0 ]]; then
  echo "DO NOT RUN AS ROOT"
  exit 1
fi

#Home Directory of the non root user
user_home=$HOME

#Getting sudo privileges
sudo -v

#Cloning Suckless software and dotfiles
git clone https://github.com/0xonomy/suckless $user_home/.config/suckless/
git clone https://github.com/0xonomy/dotfiles $user_home/.config/dotfiles/

#Installing suckless software
cd $user_home/.config/suckless/dwm
sudo make clean install
cd $user_home/.config/suckless/st
sudo make clean install
cd $user_home/.config/suckless/dwmblocks
sudo make clean install
cd $user_home/.config/suckless/dmenu
sudo make clean install

#Setting up dotfiles
cd $user_home/.config/dotfiles/
cp -r $user_home/.config/dotfiles/wall $user_home/.config/wall/
mv $user_home/.bashrc $user_home/.bashrc-old
cp $user_home/.config/dotfiles/bashrc $user_home/.bashrc
sudo cp $user_home/.config/dotfiles/usr/bin/* /usr/bin/

#Add DWM to xsessions
sudo echo > /usr/share/xsessions/dwm.desktop<< EOF
[Desktop Entry]
Encoding=UTF-8
Name=dwm
Comment=Dynamic window manager
Exec=dwm
Icon=DWM
Type=XSession
EOF
