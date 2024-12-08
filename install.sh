#!/bin/bash
#Colours
greenColour="\e[0;32m\033[1m"
endColour="\033[0m\e[0m"

#Directorio actual
ruta=$(pwd)
#Actualizar repositorios
sudo apt update
sudo apt -y upgrade

# Dependencias iniciales
sudo apt -y install build-essential git vim xcb libxcb-util0-dev libxcb-ewmh-dev libxcb-randr0-dev libxcb-icccm4-dev libxcb-keysyms1-dev libxcb-xinerama0-dev libasound2-dev libxcb-xtest0-dev libxcb-shape0-dev

# Depedencias polybar
sudo -y apt install cmake cmake-data pkg-config python3-sphinx libcairo2-dev libxcb1-dev libxcb-util0-dev libxcb-randr0-dev libxcb-composite0-dev python3-xcbgen xcb-proto libxcb-image0-dev libxcb-ewmh-dev libxcb-icccm4-dev libxcb-xkb-dev libxcb-xrm-dev libxcb-cursor-dev libasound2-dev libpulse-dev libjsoncpp-dev libmpdclient-dev libcurl4-openssl-dev libnl-genl-3-dev libuv1-dev

# Dependencias picom
sudo -y apt install meson libxext-dev libxcb1-dev libxcb-damage0-dev libxcb-xfixes0-dev libxcb-shape0-dev libxcb-render-util0-dev libxcb-render0-dev libxcb-randr0-dev libxcb-composite0-dev libxcb-image0-dev libxcb-present-dev libxcb-xinerama0-dev libpixman-1-dev libdbus-1-dev libconfig-dev libgl1-mesa-dev  libpcre2-dev  libevdev-dev uthash-dev libev-dev libx11-xcb-dev libxcb-glx0-dev

# Dependencias adicionales
sudo apt -y install bspwm sxhkd kitty zsh polybar rofi picom thunar neofetch snapd feh fzf lsd bat flameshot brightnessctl i3lock-fancy zsh-syntax-highlighting zsh-autosuggestions network-manager-gnome blueman bluez python3-dbus python3-gi

#Instalar lightdm
#sudo apt -y install lightdm

# Instalar obsidian
sudo snap install obsidian --classic

# Instalar vscode
sudo snap install --classic code 

# Instalar firefox
#sudo snap install firefox

# Crear carpeta de configuración
mkdir -p ~/.config
mkdir -p ~/repos
sudo mkdir -p /root/.config/kitty
mkdir -p ~/Wallpapers

# Clonar repositorios
cd ~/repos
git clone https://github.com/baskerville/bspwm.git
git clone https://github.com/baskerville/sxhkd.git
git clone https://github.com/ibhagwan/picom.git
git clone --recursive https://github.com/polybar/polybar 
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/.powerlevel10k
sudo git clone --depth=1 https://github.com/romkatv/powerlevel10k.git /root/.powerlevel10k

# Instalar bspwm
cd ~/repos/bspwm/
make
sudo make install

# Instalar sxhkd
cd ~/repos/sxhkd/
make
sudo make install

# Configurar lightdm
#echo -e "sxhkd &\nexec bspwm" > ~/.xinitrc

# Agregando archivo de configuración
cp -r $ruta/configuration/. ~/.config/
sudo cp $ruta/configuration/kitty/* /root/.config/kitty/
cp $ruta/wallpaper/* ~/Wallpapers/

# Intall polybar
cd ~/repos/polybar/
mkdir build
cd build/
cmake ..
make -j$(nproc)
sudo make install

# Install picom
cd ~/repos/picom/
git submodule update --init --recursive
meson --buildtype=release . build
ninja -C build
sudo ninja -C build install

# Agregar fuentes
sudo cp -v $ruta/Hack/* /usr/local/share/fonts/
cd ~/.config/polybar/fonts
sudo cp * /usr/share/fonts/truetype/
fc-cache -v

# Instalar kitty
sudo cp -rv $ruta/kitty /opt/

# Configurar zsh
cp $ruta/.zshrc ~/

# Powerlevel10k usuario normal
cp $ruta/power10k/.p10k.zsh ~/.p10k.zsh
#echo 'source ~/.powerlevel10k/powerlevel10k.zsh-theme' >> ~/.zshrc

# Powerlevel10k root
sudo cp $ruta/power10k/root/.p10k.zsh /root/.p10k.zsh

# Establecer zsh como shell por defecto
chsh -s /usr/bin/zsh
sudo usermod --shell /usr/bin/zsh root

# Otorgar permisos
chmod +x ~/.config/bspwm/bspwmrc 
chmod +x ~/.config/polybar/launch.sh
chmod +x ~/.config/polybar/scripts/launcher
chmod +x ~/.config/polybar/scripts/powermenu
chmod +x ~/.config/polybar/scripts/powermenu_alt
chmod +x ~/.config/polybar/scripts/bluetooth-status.sh
sudo chmod +x /opt/kitty/bin/kitty
sudo chmod +x /opt/kitty/bin/kitten


# Crear enlaces simbolicos
sudo ln -s -fv ~/.zshrc /root/.zshrc

echo -e "${greenColour}[+] Instalación completada${endColour}"
echo -e "${greenColour}[+] Por favor reinicie su sistema${endColour}"
echo -e "${greenColour}[+] Para cambiar el tema de rofi ejecute el siguiente comando:${endColour}"
echo -e "${greenColour}[+] rofi-theme-selector${endColour}"
