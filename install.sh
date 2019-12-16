#!/bin/bash

echo \#=======================================\#
echo \#        wigymtv doublew project        \#
echo \#       love2d all the way, baby!       \#
echo \#=======================================\#
echo \#            made by vignedev           \#
echo \#---------------------------------------\#
echo
echo Warning: this script was tested only on # actually it wasn't tested 
echo          Debian 10 Buster \(Raspbian\). # as of time of writing lol
echo
echo Also, this requires GPU OpenGL driver to
echo be installed and enabled. The app was
echo tested on RPi4. It was also tested under
echo 128MB GPU memory split however a lower
echo value could be possible used. 
echo

if [[ `id -u` -ne 0 ]] ; then echo "Please run as root" ; exit 1 ; fi

# Ensure we have the latest repositories
apt update

# Install git           (to fetch the repository)
#         love          (the 2d engine)
#         xserver-xorg  (xserver)
#         xinit         (to have easy startx)
apt install git love xserver-xorg xinit -y

# Clone the repository
git clone https://github.com/vignedev/sayotv
chown -R $SUDO_USER:$SUDO_USER "$(pwd)/sayotv"

# AutoUpdater (that has not been tested)
echo "cd $(pwd)/sayotv" > "/home/$SUDO_USER/sayoTV.sh"
echo "git fetch" >> "/home/$SUDO_USER/sayoTV.sh"
echo "git stash" >> "/home/$SUDO_USER/sayoTV.sh"
echo "git pull" >> "/home/$SUDO_USER/sayoTV.sh"
echo "git stash pop" >> "/home/$SUDO_USER/sayoTV.sh"
echo "love $(pwd)/sayotv" >> "/home/$SUDO_USER/sayoTV.sh"
chmod +x "/home/$SUDO_USER/sayoTV.sh"

# Set autolaunch in .xinitrc
echo "/home/$SUDO_USER/sayoTV.sh" >> "/home/$SUDO_USER/.xinitrc"

# Automatically launch it when bashrc
echo "if [[\"\$(tty)\" == \"/dev/tty1\" ]]; then" >> "/home/$SUDO_USER/.bashrc"
echo "startx" >> "/home/$SUDO_USER/.bashrc"
echo "fi" >> "/home/$SUDO_USER/.bashrc"

# Enable GPU support and Memory Split
raspi-config nonint do_memory_split 128
raspi-config nonint do_gldriver G2 # enable it manually, I had issues with this cmd
raspi-config nonint do_boot_behaviour B2 # automatically login to console

echo
echo "Done. Restart if needed, run by startx or enable it with raspi-config."