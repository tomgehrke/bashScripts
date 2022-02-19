#!/bin/bash
# Install Desktop Customizations

# PREPARATION --------------------

echo Adding sources...
echo =============================================
curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
sudo install -o root -g root -m 644 microsoft.gpg /etc/apt/trusted.gpg.d/
sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/edge stable main" > /etc/apt/sources.list.d/microsoft-edge-dev.list'
sudo sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/trusted.gpg.d/microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
sudo rm microsoft.gpg

echo Refresh updates...
echo =============================================
sudo apt update

echo Install packages...
echo =============================================
sudo apt install -y fonts-tlwg-garuda-ttf
sudo apt install -y apt-transport-https
sudo apt install -y code
sudo apt install -y microsoft-edge-stable
sudo apt install -y latte-dock
sudo apt install -y qt5-style-kvantum qt5-style-kvantum-themes

# DOWNLOADS ----------------------

echo Download and install Oh-My-Posh...
echo ==============================================
sudo wget https://github.com/JanDeDobbeleer/oh-my-posh/releases/latest/download/posh-linux-amd64 -O /usr/local/bin/oh-my-posh
sudo chmod +x /usr/local/bin/oh-my-posh

mkdir ~/.poshthemes
wget https://github.com/JanDeDobbeleer/oh-my-posh/releases/latest/download/themes.zip -O ~/.poshthemes/themes.zip
unzip ~/.poshthemes/themes.zip -d ~/.poshthemes
chmod u+rw ~/.poshthemes/*.json
rm ~/.poshthemes/themes.zip

echo -e "\n# OH-MY-POSH\neval \"\$(oh-my-posh --init --shell bash --config ~/.poshthemes/mt.omp.json)\"" | tee --append ~/.bashrc
source ~/.bashrc

echo Download and install Nordic theme...
echo ==============================================
git clone https://github.com/EliverLara/Nordic ~/Nordic
cp --archive --force ~/Nordic/kde/* ~/.local/share
mkdir -p ~/.config/Kvantum
mv --force ~/.local/share/kvantum/Nordic* ~/.config/Kvantum/
mv --force ~/.local/share/colorschemes ~/.local/share/color-schemes
mkdir -p ~/.local/share/aurorae/themes # Window Decorations
mv --force ~/.local/share/aurorae/Nordic* ~/.local/share/aurorae/themes/

echo Download and install Papirus icons...
echo ===============================================
wget -qO- https://raw.githubusercontent.com/PapirusDevelopmentTeam/papirus-icon-theme/master/install.sh | sh

echo Download and install Caskaydia Cove NerdFont...
echo ===============================================
wget -q https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/CascadiaCode.zip -O ~/CascadiaCode.zip
unzip -qo ~/CascadiaCode.zip -d ~/.fonts
fc-cache -fv

# INSTALLATION -------------------

# Enable theme
lookandfeeltool --apply Nordic-darker

# FIXES --------------------------
# ToDo: check for existence of lines first

echo Fix login screen on hiDPI display...
echo ===============================================
echo -e "xrandr --output eDP-1 --mode 1920x1080 --rate 60.01" | sudo tee --append /usr/share/sddm/scripts/Xsetup

echo Fix GRUB menu on hiDPI display...
echo ===============================================
echo -e "GRUB_GFXPAYLOAD=keep\nGRUB_TERMINAL=gfxterm\nGRUB_GFXMODE=800x600" | sudo tee --append /etc/default/grub 
sudo update-grub 

# FINAL TOUCHES --------------------------

echo Select default browser...
sudo update-alternatives --config x-www-browser

echo Navigate to Nord Chrome/Edge theme...
echo ===============================================
xdg-open https://chrome.google.com/webstore/detail/nord/abehfkkfjlplnjadfcjiflnejblfmmpj
