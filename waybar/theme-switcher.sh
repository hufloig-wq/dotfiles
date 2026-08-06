#!/bin/bash

THEMES_DIR="$HOME/.config/waybar/themes"
STYLE="$HOME/.config/waybar/style.css"
APPEARANCE_LUA="$HOME/.config/hypr/modules/appearance.lua"
HYPRLOCK_CONF="$HOME/.config/hypr/hyprlock.conf"
SDDM_CONF="/usr/share/sddm/themes/sddm-astronaut-theme/Themes/astronaut.conf"
CURRENT_FILE="/tmp/waybar-current-theme"

mkdir -p "$THEMES_DIR"

THEMES=("tokyo-night" "catppuccin" "gruvbox" "minimal" "athena")
THEME_NAMES=("Tokyo Night" "Catppuccin Mocha" "Gruvbox Dark" "Minimal Dark" "Athena Material")
THEME_ICONS=("🌙" "🌸" "🌿" "⬛" "🔵")

declare -A ACTIVE_BORDER=(
    ["tokyo-night"]="rgba(7287fdee) rgba(1e66f5ee) 45"
    ["catppuccin"]="rgba(cba6f7ee) rgba(89b4faee) 45"
    ["gruvbox"]="rgba(fabd2fee) rgba(fe8019ee) 45"
    ["minimal"]="rgba(ffffffff) rgba(888888ee) 45"
    ["athena"]="rgba(88d1ecee) rgba(b3cad4ee) 45"
)

declare -A INACTIVE_BORDER=(
    ["tokyo-night"]="rgba(595959aa)"
    ["catppuccin"]="rgba(45475aaa)"
    ["gruvbox"]="rgba(504945aa)"
    ["minimal"]="rgba(444444aa)"
    ["athena"]="rgba(40484caa)"
)

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

# ── Color de acento SDDM por tema (hex plano, sin alpha) ──────
declare -A SDDM_ACCENT=(
    ["tokyo-night"]="#7aa2f7"
    ["catppuccin"]="#cba6f7"
    ["gruvbox"]="#fabd2f"
    ["minimal"]="#ffffff"
    ["athena"]="#88d1ec"
)

# ── Leer tema actual ────────────────────────────────────────
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

# ── Waybar ──────────────────────────────────────────────────
cp "$THEMES_DIR/$NEXT_THEME.css" "$STYLE"

# ── Hyprland (Lua) ──────────────────────────────────────────
read -r C1 C2 ANGLE <<< "${ACTIVE_BORDER[$NEXT_THEME]}"
sed -i "s|active_border = .*|active_border = { colors = { \"$C1\", \"$C2\" }, angle = $ANGLE },|" "$APPEARANCE_LUA"
sed -i "s|inactive_border = .*|inactive_border = \"${INACTIVE_BORDER[$NEXT_THEME]}\",|" "$APPEARANCE_LUA"
hyprctl reload

# ── Hyprlock ────────────────────────────────────────────────
sed -i "s|outer_color = .*|outer_color = ${LOCK_OUTER_COLOR[$NEXT_THEME]}|" "$HYPRLOCK_CONF"
sed -i "s|check_color = .*|check_color = ${LOCK_CHECK_COLOR[$NEXT_THEME]}|" "$HYPRLOCK_CONF"

# ── SDDM (script dedicado con sudo sin password) ──────────────
sudo /usr/local/bin/apply-sddm-theme.sh "${SDDM_ACCENT[$NEXT_THEME]}"

# ── Guardar tema actual ───────────────────────────────────────
echo "$NEXT_THEME" > "$CURRENT_FILE"

# ── Notificar ─────────────────────────────────────────────────
notify-send -u low "${NEXT_ICON} Tema aplicado" "Waybar + Hyprland + Hyprlock + SDDM: $NEXT_NAME" -t 2000
