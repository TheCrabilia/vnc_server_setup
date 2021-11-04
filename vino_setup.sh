read -sp "Enter VNC password: " PASSWORD

# Install Vino VNC server
sudo apt-get install vino

# Setup Vino
gsettings set org.gnome.Vino require-encryption false
gsettings set org.gnome.Vino prompt-enabled false
gsettings set org.gnome.Vino disable-xdamage true
gsettings set org.gnome.Vino authentication-methods "['vnc']"
gsettings set org.gnome.Vino vnc-password $(echo -n $PASSWORD | base64)

read -p "Reboot now? (y/N) " REBOOT
if [[ $REBOOT = [yY] ]]; then
    sudo reboot
fi

