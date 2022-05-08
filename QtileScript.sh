#!/usr/bin/env bash
echo -ne "
--------------------------------------------------------------------------------------------
 ██████╗ █████╗ ██████╗ ███╗   ██╗███████╗██╗     ██╗ █████╗ ███╗   ██╗     ██████╗ ███████╗
██╔════╝██╔══██╗██╔══██╗████╗  ██║██╔════╝██║     ██║██╔══██╗████╗  ██║    ██╔═══██╗██╔════╝
██║     ███████║██████╔╝██╔██╗ ██║█████╗  ██║     ██║███████║██╔██╗ ██║    ██║   ██║███████╗
██║     ██╔══██║██╔══██╗██║╚██╗██║██╔══╝  ██║     ██║██╔══██║██║╚██╗██║    ██║   ██║╚════██║
╚██████╗██║  ██║██║  ██║██║ ╚████║███████╗███████╗██║██║  ██║██║ ╚████║    ╚██████╔╝███████║
 ╚═════╝╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═══╝╚══════╝╚══════╝╚═╝╚═╝  ╚═╝╚═╝  ╚═══╝     ╚═════╝ ╚══════╝
--------------------------------------------------------------------------------------------
                                              By
                                         Stelios Mitas
--------------------------------------------------------------------------------------------
"
grep -qs "#ParallelDownloads" /etc/pacman.conf && speedwarning
grep -qs "ID=arch" /etc/os-release || distrowarning

sleep 2
echo -ne"
                            Installing Carnelias OS - Qtile Edition"
sleep 1
echo "
# choose video driver
echo

1) xf86-video-intel 	2) xf86-video-amdgpu 3) nvidia 4) Skip"
read -r -p "Choose you video card driver(default 1)(will not re-install): " vid

case $vid in
[1])
	DRI='xf86-video-intel'
	;;

[2])
	DRI='xf86-video-amdgpu'
	;;

[3])
    DRI='nvidia nvidia-settings nvidia-utils'
    ;;

[4])
	DRI=""
	;;
[*])
	DRI='xf86-video-intel'
	;;
esac

echo "We need an AUR helper. It is essential. 1) paru       2) yay"
read -r -p "What is the AUR helper of your choice? (Default is paru): " num

if [ $num -eq 2 ]
then
    HELPER="yay"
fi

if ! command -v $HELPER &> /dev/null
then
    echo "It seems that you don't have $HELPER installed, I'll install that for you before continuing."
	git clone https://aur.archlinux.org/$HELPER.git ~/.srcs/$HELPER
	(cd ~/.srcs/$HELPER/ && makepkg -si )
fi
"
###################################   Installing Packages   ################################
                                             PACMAN

sudo pacman --needed --ask 4 -Sy - < packages.txt
"
echo -ne
"

###################################   Installing Packages   ################################

                                     Arch User Repository
"
$HELPER --needed --ask 4 -Sy - < aur.txt


echo "#########################################################"
echo "## Installing Doom Emacs. This may take a few minutes. ##"
echo "#########################################################"
[ -d ~/.emacs.d ] && mv ~/.emacs.d ~/.emacs.d.bak.$(date +"%Y%m%d_%H%M%S")
[ -f ~/.emacs ] && mv ~/.emacs ~/.emacs.bak.$(date +"%Y%m%d_%H%M%S")
git clone --depth 1 https://github.com/hlissner/doom-emacs ~/.emacs.d
~/.emacs.d/bin/doom -y install
~/.emacs.d/bin/doom sync


echo -ne
"
##########################   Copying and Applying Configurations   ##########################
"
sleep 1
cp -r ~/QtileConfig/.config/qtile ~/.config/
cp -r ~/QtileConfig/.config/kitty ~/.config/
cp -r ~/QtileConfig/.config/alacritty ~/.config/
cp -r ~/QtileConfig/.config/qutebrowser ~/.config/
cp -r ~/QtileConfig/.config/fish ~/.config/
cp -r ~/QtileConfig/.config/neofetch ~/.config/
cp -r ~/QtileConfig/.config/picom.conf ~/.config/
cp -r ~/QtileConfig/.config/Thunar ~/.config/
cp -r ~/QtileConfig/.config/rofi ~/.config/
cp -r ~/QtileConfig/wallpapers ~/.wallpapers


echo "###################################"
echo "## Enable LighDM as login manager.#"
echo "###################################"

sudo systemctl enable lightdm
sudo systemctl enable lightdm.service

sudo chsh $USER -s "/usr/bin/fish" && \
            echo -e "Fish has been set as your default USER shell. \
                    \nLogging out is required for this take effect."


while true; do
    read -p "Do you want to reboot your Carnelian OS? [Y/n] " yn
    case $yn in
        [Yy]* ) reboot;;
        [Nn]* ) break;;
        "" ) reboot;;
        * ) echo "Please answer yes or no.";;
    esac
done
