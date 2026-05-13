#!/bin/bash

SHUTDOWN="󰐥  Apagar"
REBOOT="󰜉  Reiniciar"
SUSPEND="󰒲  Suspender"
HIBERNATE="󰋊  Hibernar"
LOGOUT="󰍃  Cerrar sesión"
LOCK="󰌾  Bloquear"

CHOSEN=$(printf "$LOCK\n$REBOOT\n$SHUTDOWN" | wofi \
    --show dmenu \
    --prompt "  Power Menu" \
    --width 150 \
    --height 140 \
    --location top-right \
    --xoffset 1080 \
    --yoffset 0 \
    --no-actions \
    --insensitive \
    --hide-search \
    --style ~/.config/wofi/power-menu.css \
    --define=key_expand=)

case "$CHOSEN" in
    "$SHUTDOWN")
        systemctl poweroff
        ;;
    "$REBOOT")
        systemctl reboot
        ;;
    "$SUSPEND")
        systemctl suspend
        ;;
    "$HIBERNATE")
        systemctl hibernate
        ;;
    "$LOGOUT")
        hyprctl dispatch exit
        ;;
    "$LOCK")
        hyprlock
        ;;
esac
