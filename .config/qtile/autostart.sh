#!/usr/bin/env bash 

festival --tts $HOME/.config/qtile/welcome_msg &
lxsession &
picom &
/usr/bin/emacs --daemon &
conky -c /home/mitas/.config/conky/qutile/doom-one-01.conkyrc &
volumeicon &
nm-applet &
run variety &
run nm-applet &
run pamac-tray &
run xfce4-power-manager &
numlockx on &
blueberry-tray &
run volumeicon &

#feh --bg-scale /usr/share/backgrounds/dtos-backgrounds/0310.jpg
feh --randomize --bg-fill ~/.wallpapers
### UNCOMMENT ONLY ONE OF THE FOLLOWING THREE OPTIONS! ###
# 1. Uncomment to restore last saved wallpaper
xargs xwallpaper --stretch < ~/.xwallpaper &
# 2. Uncomment to set a random wallpaper on login
# find /usr/share/backgrounds/dtos-backgrounds/ -type f | shuf -n 1 | xargs xwallpaper --stretch &
# 3. Uncomment to set wallpaper with nitrogen
# nitrogen --restore &
