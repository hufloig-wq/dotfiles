#!/bin/bash

BATTERY=$(cat /sys/class/power_supply/BAT0/capacity 2>/dev/null || cat /sys/class/power_supply/BAT1/capacity 2>/dev/null)
STATUS=$(cat /sys/class/power_supply/BAT0/status 2>/dev/null || cat /sys/class/power_supply/BAT1/status 2>/dev/null)

# Archivo para evitar notificaciones repetidas
STATE_FILE="/tmp/battery-notify-state"
CURRENT_STATE=""

if [ "$STATUS" = "Discharging" ]; then
    if [ "$BATTERY" -le 5 ]; then
        CURRENT_STATE="critical"
        if [ "$(cat $STATE_FILE 2>/dev/null)" != "$CURRENT_STATE" ]; then
            notify-send -u critical "󰁺 Batería Crítica" "Batería al ${BATTERY}% — Conecta el cargador ahora!" -t 0
            paplay /usr/share/sounds/freedesktop/stereo/dialog-error.oga 2>/dev/null &
            echo "$CURRENT_STATE" > "$STATE_FILE"
        fi
    elif [ "$BATTERY" -le 10 ]; then
        CURRENT_STATE="low"
        if [ "$(cat $STATE_FILE 2>/dev/null)" != "$CURRENT_STATE" ]; then
            notify-send -u critical "󰁻 Batería Baja" "Batería al ${BATTERY}% — Conecta el cargador pronto" -t 10000
            paplay /usr/share/sounds/freedesktop/stereo/dialog-warning.oga 2>/dev/null &
            echo "$CURRENT_STATE" > "$STATE_FILE"
        fi
    elif [ "$BATTERY" -le 30 ]; then
        CURRENT_STATE="warning"
        if [ "$(cat $STATE_FILE 2>/dev/null)" != "$CURRENT_STATE" ]; then
            notify-send -u normal "󰁽 Batería" "Batería al ${BATTERY}%" -t 5000
            echo "$CURRENT_STATE" > "$STATE_FILE"
        fi
    else
        echo "normal" > "$STATE_FILE"
    fi
elif [ "$STATUS" = "Full" ] || { [ "$STATUS" = "Charging" ] && [ "$BATTERY" -ge 100 ]; }; then
    CURRENT_STATE="full"
    if [ "$(cat $STATE_FILE 2>/dev/null)" != "$CURRENT_STATE" ]; then
        notify-send -u normal "󰁹 Batería Completa" "Batería al 100% — Puedes desconectar el cargador" -t 8000
        paplay /usr/share/sounds/freedesktop/stereo/complete.oga 2>/dev/null &
        echo "$CURRENT_STATE" > "$STATE_FILE"
    fi
elif [ "$STATUS" = "Charging" ]; then
    echo "charging" > "$STATE_FILE"
fi
