#!/bin/bash
# ──────────────────────────────────────────────────────────────
#  HprHufloig's Dotfiles — Install Script
#  Arch Linux + Hyprland
# ──────────────────────────────────────────────────────────────

set -e

# Colores
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m'

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo -e "${CYAN}"
echo "  ██╗  ██╗██████╗ ██████╗ "
echo "  ██║  ██║██╔══██╗██╔══██╗"
echo "  ███████║██████╔╝██████╔╝"
echo "  ██╔══██║██╔═══╝ ██╔══██╗"
echo "  ██║  ██║██║     ██║  ██║"
echo "  ╚═╝  ╚═╝╚═╝     ╚═╝  ╚═╝"
echo -e "${NC}"
echo -e "${BLUE}  HprHufloig's Dotfiles — Arch Linux + Hyprland${NC}"
echo -e "${BLUE}  ─────────────────────────────────────────────${NC}\n"

# ── Verificar que es Arch Linux ──────────────────────────────
if ! command -v pacman &>/dev/null; then
    echo -e "${RED}✗ Este script es solo para Arch Linux${NC}"
    exit 1
fi

# ── Funciones ─────────────────────────────────────────────────
backup_and_link() {
    local src="$1"
    local dest="$2"
    local desc="$3"

    mkdir -p "$(dirname "$dest")"

    if [[ -e "$dest" && ! -L "$dest" ]]; then
        local backup="$HOME/.dotfiles_backup/$(date +%Y%m%d_%H%M%S)/$(basename "$dest")"
        mkdir -p "$(dirname "$backup")"
        mv "$dest" "$backup"
        echo -e "${YELLOW}  ⚠ Backup: $(basename "$dest") → $backup${NC}"
    fi

    rm -rf "$dest"
    ln -sf "$src" "$dest"
    echo -e "${GREEN}  ✓ $desc${NC}"
}

install_packages() {
    echo -e "\n${BLUE}📦 Instalando paquetes oficiales...${NC}"
    if [[ -f "$DOTFILES_DIR/pkglist.txt" ]]; then
        sudo pacman -S --needed - < "$DOTFILES_DIR/pkglist.txt"
        echo -e "${GREEN}  ✓ Paquetes oficiales instalados${NC}"
    else
        echo -e "${YELLOW}  ⚠ pkglist.txt no encontrado${NC}"
    fi
}

install_aur_packages() {
    echo -e "\n${BLUE}📦 Instalando paquetes AUR...${NC}"
    if ! command -v yay &>/dev/null; then
        echo -e "${YELLOW}  yay no encontrado, instalando...${NC}"
        sudo pacman -S --needed git base-devel
        git clone https://aur.archlinux.org/yay.git /tmp/yay
        cd /tmp/yay && makepkg -si && cd -
    fi
    if [[ -f "$DOTFILES_DIR/aur-pkglist.txt" ]]; then
        yay -S --needed - < "$DOTFILES_DIR/aur-pkglist.txt"
        echo -e "${GREEN}  ✓ Paquetes AUR instalados${NC}"
    else
        echo -e "${YELLOW}  ⚠ aur-pkglist.txt no encontrado${NC}"
    fi
}

install_symlinks() {
    echo -e "\n${BLUE}🔗 Creando symlinks...${NC}"

    # Hyprland
    [[ -d "$DOTFILES_DIR/hypr" ]] && \
        backup_and_link "$DOTFILES_DIR/hypr" "$HOME/.config/hypr" "Hyprland config"

    # Waybar
    [[ -d "$DOTFILES_DIR/waybar" ]] && \
        backup_and_link "$DOTFILES_DIR/waybar" "$HOME/.config/waybar" "Waybar config"

    # Ghostty
    [[ -d "$DOTFILES_DIR/ghostty" ]] && \
        backup_and_link "$DOTFILES_DIR/ghostty" "$HOME/.config/ghostty" "Ghostty config"

    # Wofi
    [[ -d "$DOTFILES_DIR/wofi" ]] && \
        backup_and_link "$DOTFILES_DIR/wofi" "$HOME/.config/wofi" "Wofi config"

    # Yazi
    [[ -d "$DOTFILES_DIR/yazi" ]] && \
        backup_and_link "$DOTFILES_DIR/yazi" "$HOME/.config/yazi" "Yazi config"

    # Fastfetch
    [[ -d "$DOTFILES_DIR/fastfetch" ]] && \
        backup_and_link "$DOTFILES_DIR/fastfetch" "$HOME/.config/fastfetch" "Fastfetch config"

    # Btop
    [[ -d "$DOTFILES_DIR/btop" ]] && \
        backup_and_link "$DOTFILES_DIR/btop" "$HOME/.config/btop" "Btop config"

    # Nvim
    [[ -d "$DOTFILES_DIR/nvim" ]] && \
        backup_and_link "$DOTFILES_DIR/nvim" "$HOME/.config/nvim" "Neovim config"

    # Zellij
    [[ -d "$DOTFILES_DIR/zellij" ]] && \
        backup_and_link "$DOTFILES_DIR/zellij" "$HOME/.config/zellij" "Zellij config"

    # Kitty
    [[ -d "$DOTFILES_DIR/kitty" ]] && \
        backup_and_link "$DOTFILES_DIR/kitty" "$HOME/.config/kitty" "Kitty config"

    # Waypaper
    [[ -d "$DOTFILES_DIR/waypaper" ]] && \
        backup_and_link "$DOTFILES_DIR/waypaper" "$HOME/.config/waypaper" "Waypaper config"

    # NetworkManager dmenu
    [[ -d "$DOTFILES_DIR/networkmanager-dmenu" ]] && \
        backup_and_link "$DOTFILES_DIR/networkmanager-dmenu" "$HOME/.config/networkmanager-dmenu" "NetworkManager dmenu config"

    # yt-dlp
    [[ -d "$DOTFILES_DIR/yt-dlp" ]] && \
        backup_and_link "$DOTFILES_DIR/yt-dlp" "$HOME/.config/yt-dlp" "yt-dlp config"

    # VSCode
    if command -v code &>/dev/null && [[ -f "$DOTFILES_DIR/vscode/settings.json" ]]; then
        backup_and_link "$DOTFILES_DIR/vscode/settings.json" "$HOME/.config/Code/User/settings.json" "VSCode settings"
        backup_and_link "$DOTFILES_DIR/vscode/keybindings.json" "$HOME/.config/Code/User/keybindings.json" "VSCode keybindings"
    fi

    # Cursor editor
    if [[ -d "$DOTFILES_DIR/cursor" ]]; then
        [[ -f "$DOTFILES_DIR/cursor/cursor.desktop" ]] && \
            backup_and_link "$DOTFILES_DIR/cursor/cursor.desktop" "$HOME/.local/share/applications/cursor.desktop" "Cursor desktop file"
        [[ -f "$DOTFILES_DIR/cursor/cursor.png" ]] && \
            backup_and_link "$DOTFILES_DIR/cursor/cursor.png" "$HOME/.local/share/icons/cursor.png" "Cursor icon"
        if [[ -f "$DOTFILES_DIR/cursor/cursor" ]]; then
            backup_and_link "$DOTFILES_DIR/cursor/cursor" "$HOME/.local/bin/cursor" "Cursor executable"
            chmod +x "$HOME/.local/bin/cursor"
        fi
    fi

    # Scripts en bin
    if [[ -d "$DOTFILES_DIR/bin" ]]; then
        mkdir -p "$HOME/.local/bin"
        for script in "$DOTFILES_DIR/bin"/*; do
            [[ -f "$script" ]] && \
                backup_and_link "$script" "$HOME/.local/bin/$(basename "$script")" "Script: $(basename "$script")" && \
                chmod +x "$HOME/.local/bin/$(basename "$script")"
        done
    fi

    # Zsh
    [[ -f "$DOTFILES_DIR/zsh/zshrc" ]] && \
        backup_and_link "$DOTFILES_DIR/zsh/zshrc" "$HOME/.zshrc" "Zsh config"
}

install_fonts() {
    echo -e "\n${BLUE}🔤 Instalando fuentes...${NC}"
    sudo pacman -S --needed \
        ttf-zed-mono-nerd \
        ttf-space-mono-nerd \
        otf-font-awesome \
        ttf-font-awesome
    echo -e "${GREEN}  ✓ Fuentes instaladas${NC}"
}

install_zsh_plugins() {
    echo -e "\n${BLUE}🐚 Instalando plugins de Zsh...${NC}"
    sudo pacman -S --needed zsh-autosuggestions zsh-syntax-highlighting
    echo -e "${GREEN}  ✓ Plugins de Zsh instalados${NC}"
}

make_scripts_executable() {
    echo -e "\n${BLUE}🔧 Dando permisos a scripts de Waybar...${NC}"
    chmod +x "$HOME/.config/waybar/"*.sh 2>/dev/null || true
    echo -e "${GREEN}  ✓ Permisos aplicados${NC}"
}

# ── Menú de instalación ───────────────────────────────────────
echo -e "${CYAN}¿Qué deseas instalar?${NC}"
echo -e "  ${GREEN}1)${NC} Instalación completa (paquetes + symlinks + fuentes)"
echo -e "  ${GREEN}2)${NC} Solo symlinks"
echo -e "  ${GREEN}3)${NC} Solo paquetes"
echo -e "  ${GREEN}4)${NC} Solo fuentes"
echo -e "  ${GREEN}q)${NC} Salir"
echo ""
read -rp "Opción: " choice

case "$choice" in
    1)
        install_packages
        install_aur_packages
        install_fonts
        install_zsh_plugins
        install_symlinks
        make_scripts_executable
        ;;
    2)
        install_symlinks
        make_scripts_executable
        ;;
    3)
        install_packages
        install_aur_packages
        ;;
    4)
        install_fonts
        ;;
    q)
        echo -e "${YELLOW}Saliendo...${NC}"
        exit 0
        ;;
    *)
        echo -e "${RED}Opción inválida${NC}"
        exit 1
        ;;
esac

# ── Fin ───────────────────────────────────────────────────────
echo -e "\n${GREEN}🎉 ¡Instalación completada!${NC}"
echo -e "${BLUE}  Próximos pasos:${NC}"
echo -e "  1. Recarga la terminal: ${YELLOW}source ~/.zshrc${NC}"
echo -e "  2. Reinicia la sesión de Hyprland"
echo -e "  3. Selecciona tu wallpaper con: ${YELLOW}waypaper${NC}"
echo -e "\n${CYAN}  ✨ Enjoy your setup, HprHufloig!${NC}\n"
