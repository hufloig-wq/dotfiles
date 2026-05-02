#!/bin/bash

active=$(systemctl --user is-active dropbox 2>/dev/null)

case "$active" in
    "active")
        echo '{"text": "󰇣", "tooltip": "Dropbox: Corriendo", "class": "synced"}'
        ;;
    "activating")
        echo '{"text": "󰇣", "tooltip": "Dropbox: Iniciando...", "class": "connecting"}'
        ;;
    *)
        echo '{"text": "󰇣", "tooltip": "Dropbox: Detenido - Click para iniciar", "class": "stopped"}'
        ;;
esac
