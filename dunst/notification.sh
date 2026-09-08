#!/bin/sh
if [ "$DUNST_APP_NAME" != "Spotify" ]; then
    paplay "$HOME/.config/dunst/notification.ogg"
fi
