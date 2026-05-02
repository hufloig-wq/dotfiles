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
    --width 250 \
    --height 310 \
    --no-actions \
    --insensitive \
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
