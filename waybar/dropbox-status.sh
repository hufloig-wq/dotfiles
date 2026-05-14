#!/bin/bash

# Verificar si dropbox está corriendo por proceso
if pgrep -f "dropbox" > /dev/null 2>&1; then
    # Intentar obtener status con timeout muy corto
    status=$(timeout 2 dropbox status 2>/dev/null | head -1)
    case "$status" in
        "Up to date")
            echo '{"text": "󰇣", "tooltip": "Dropbox: Sincronizado", "class": "synced"}'
            ;;
        "Syncing"*|"Uploading"*|"Downloading"*)
            echo '{"text": "󰇣", "tooltip": "Dropbox: '"$status"'", "class": "syncing"}'
            ;;
        "Connecting"*|"Starting"*)
            echo '{"text": "󰇣", "tooltip": "Dropbox: Conectando...", "class": "connecting"}'
            ;;
        *)
            echo '{"text": "󰇣", "tooltip": "Dropbox: Corriendo", "class": "syncing"}'
            ;;
    esac
else
    echo '{"text": "󰇣", "tooltip": "Dropbox: Detenido - Click para iniciar", "class": "stopped"}'
fi
