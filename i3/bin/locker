#!/bin/bash
# Source: https://github.com/LukeSmithxyz/voidrice/blob/master/.config/i3/lock.sh

# Take a screenshot:
scrot /tmp/screen.png

# Create a blur on the shot:
convert /tmp/screen.png -resize 10% /tmp/screen.png
convert /tmp/screen.png -resize 1000% /tmp/screen.png

# Add the lock to the blurred image:
[[ -f ~/.config/i3/lock.png ]] && convert /tmp/screen.png  ~/.config/i3/lock.png -gravity center -composite -matte /tmp/screen.png

# Lock it up!
i3lock -e -f -c 000000 -i /tmp/screen.png

# If still locked after 20 seconds, turn off screen. After additional 20 seconds suspend system
sleep 20 && pgrep i3lock && \
xset dpms force off && \
sleep 20 && pgrep i3lock && \
systemctl suspend
