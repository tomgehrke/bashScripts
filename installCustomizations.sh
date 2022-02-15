#!/bin/bash
# Install Desktop Customizations

# PREPARATION --------------------
sudo add-apt-repository ppa:rikmills/latte-dock
sudo apt update

# Install Git
sudo apt install git

# Install Latte Dock
sudo apt install latte-dock

# DOWNLOADS ----------------------

# Download Nordic GTK Theme
git clone https://github.com/EliverLara/Nordic.git ~/Nordic
# Move to system themes folder
sudo mv ~/Nordic/ /usr/share/themes/

# Download and run Papirus installation script
wget -qO- https://raw.githubusercontent.com/PapirusDevelopmentTeam/papirus-icon-theme/master/install.sh | sh

# INSTALLATION -------------------

# Enable theme
lookandfeeltool --apply Nordic

# CLEANUP ------------------------
# ToDo: check for existence of line first
sudo echo -e "xrandr --output eDP-1 --mode 1920x1080 --rate 60.01" >> /usr/share/sddm/scripts/Xsetup
