#!/bin/bash

THEMES_DIR="$HOME/.config/waybar/themes"
STYLE="$HOME/.config/waybar/style.css"
CURRENT_FILE="/tmp/waybar-current-theme"

mkdir -p "$THEMES_DIR"

THEMES=("tokyo-night" "catppuccin" "gruvbox" "minimal")
THEME_NAMES=("Tokyo Night" "Catppuccin Mocha" "Gruvbox Dark" "Minimal Dark")
THEME_ICONS=("🌙" "🌸" "🌿" "⬛")

if [[ -f "$CURRENT_FILE" ]]; then
    CURRENT=$(cat "$CURRENT_FILE")
else
    CURRENT="tokyo-night"
    echo "$CURRENT" > "$CURRENT_FILE"
fi

CURRENT_INDEX=0
for i in "${!THEMES[@]}"; do
    if [[ "${THEMES[$i]}" == "$CURRENT" ]]; then
        CURRENT_INDEX=$i
        break
    fi
done

NEXT_INDEX=$(( (CURRENT_INDEX + 1) % ${#THEMES[@]} ))
NEXT_THEME="${THEMES[$NEXT_INDEX]}"
NEXT_NAME="${THEME_NAMES[$NEXT_INDEX]}"
NEXT_ICON="${THEME_ICONS[$NEXT_INDEX]}"

cp "$THEMES_DIR/$NEXT_THEME.css" "$STYLE"
echo "$NEXT_THEME" > "$CURRENT_FILE"

notify-send -u low "${NEXT_ICON} Tema aplicado" "Waybar: $NEXT_NAME" -t 2000
