#!/bin/bash

if pgrep -f "dropbox-lnx" > /dev/null 2>&1 || pgrep -f "/opt/dropbox/dropbox" > /dev/null 2>&1; then
    echo '{"text": "󰇣", "tooltip": "Dropbox: Corriendo", "class": "syncing"}'
else
    echo '{"text": "󰇣", "tooltip": "Dropbox: Detenido - Click para iniciar", "class": "stopped"}'
fi
