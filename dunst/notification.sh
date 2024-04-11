#!/bin/sh
# echo "DUNST_APP_NAME: $DUNST_APP_NAME" >> /home/felipe/.config/dunst/notification.log
if [ "$DUNST_APP_NAME" != "Spotify" ]; then
    paplay /home/felipe/.config/dunst/notification.ogg
fi
