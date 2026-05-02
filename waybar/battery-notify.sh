#!/bin/bash

BATTERY=$(cat /sys/class/power_supply/BAT0/capacity 2>/dev/null || cat /sys/class/power_supply/BAT1/capacity 2>/dev/null)
STATUS=$(cat /sys/class/power_supply/BAT0/status 2>/dev/null || cat /sys/class/power_supply/BAT1/status 2>/dev/null)

if [ "$STATUS" = "Discharging" ]; then
    if [ "$BATTERY" -le 5 ]; then
        notify-send -u critical "󰁺 Batería Crítica" "Batería al ${BATTERY}% — Conecta el cargador ahora!" -t 0
    elif [ "$BATTERY" -le 15 ]; then
        notify-send -u critical "󰁻 Batería Baja" "Batería al ${BATTERY}% — Conecta el cargador pronto" -t 10000
    elif [ "$BATTERY" -le 30 ]; then
        notify-send -u normal "󰁽 Batería" "Batería al ${BATTERY}%" -t 5000
    fi
fi
