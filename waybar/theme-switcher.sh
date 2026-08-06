#!/bin/bash

THEMES_DIR="$HOME/.config/waybar/themes"
STYLE="$HOME/.config/waybar/style.css"
HYPRLAND_CONF="$HOME/.config/hypr/hyprland.conf"
HYPRLOCK_CONF="$HOME/.config/hypr/hyprlock.conf"
CURRENT_FILE="/tmp/waybar-current-theme"

mkdir -p "$THEMES_DIR"

THEMES=("tokyo-night" "catppuccin" "gruvbox" "minimal" "athena")
THEME_NAMES=("Tokyo Night" "Catppuccin Mocha" "Gruvbox Dark" "Minimal Dark" "Athena Material")
THEME_ICONS=("🌙" "🌸" "🌿" "⬛" "🔵")

# ── Colores de Hyprland por tema ──────────────────────────────
declare -A ACTIVE_BORDER=(
    ["tokyo-night"]="rgba(7287fdee) rgba(1e66f5ee) 45deg"
    ["catppuccin"]="rgba(cba6f7ee) rgba(89b4faee) 45deg"
    ["gruvbox"]="rgba(fabd2fee) rgba(fe8019ee) 45deg"
    ["minimal"]="rgba(ffffffff) rgba(888888ee) 45deg"
    ["athena"]="rgba(88d1ecee) rgba(b3cad4ee) 45deg"
)

declare -A INACTIVE_BORDER=(
    ["tokyo-night"]="rgba(595959aa)"
    ["catppuccin"]="rgba(45475aaa)"
    ["gruvbox"]="rgba(504945aa)"
    ["minimal"]="rgba(444444aa)"
    ["athena"]="rgba(40484caa)"
)

# ── Colores de Hyprlock por tema ──────────────────────────────
declare -A LOCK_OUTER_COLOR=(
    ["tokyo-night"]="rgba(122, 162, 247, 1.0)"
    ["catppuccin"]="rgba(203, 166, 247, 1.0)"
    ["gruvbox"]="rgba(250, 189, 47, 1.0)"
    ["minimal"]="rgba(255, 255, 255, 1.0)"
    ["athena"]="rgba(136, 209, 236, 1.0)"
)

declare -A LOCK_CHECK_COLOR=(
    ["tokyo-night"]="rgba(158, 206, 106, 1.0)"
    ["catppuccin"]="rgba(166, 227, 161, 1.0)"
    ["gruvbox"]="rgba(184, 187, 38, 1.0)"
    ["minimal"]="rgba(255, 255, 255, 1.0)"
    ["athena"]="rgba(136, 209, 236, 1.0)"
)

# ── Leer tema actual ──────────────────────────────────────────
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

# ── Aplicar tema Waybar ───────────────────────────────────────
cp "$THEMES_DIR/$NEXT_THEME.css" "$STYLE"

# ── Aplicar colores Hyprland ──────────────────────────────────
sed -i "s|col.active_border = .*|col.active_border = ${ACTIVE_BORDER[$NEXT_THEME]}|" "$HYPRLAND_CONF"
sed -i "s|col.inactive_border = .*|col.inactive_border = ${INACTIVE_BORDER[$NEXT_THEME]}|" "$HYPRLAND_CONF"
hyprctl reload

# ── Aplicar colores Hyprlock ──────────────────────────────────
sed -i "s|outer_color = .*|outer_color = ${LOCK_OUTER_COLOR[$NEXT_THEME]}|" "$HYPRLOCK_CONF"
sed -i "s|check_color = .*|check_color = ${LOCK_CHECK_COLOR[$NEXT_THEME]}|" "$HYPRLOCK_CONF"

# ── Guardar tema actual ───────────────────────────────────────
echo "$NEXT_THEME" > "$CURRENT_FILE"

# ── Notificar ─────────────────────────────────────────────────
notify-send -u low "${NEXT_ICON} Tema aplicado" "Waybar + Hyprland: $NEXT_NAME" -t 2000
