<div align="center">

# 🌸 HprHufloig's Dotfiles

![Arch Linux](https://img.shields.io/badge/Arch_Linux-1793D1?style=for-the-badge&logo=arch-linux&logoColor=white)
![Hyprland](https://img.shields.io/badge/Hyprland-58E1FF?style=for-the-badge&logo=wayland&logoColor=black)
![Waybar](https://img.shields.io/badge/Waybar-313244?style=for-the-badge&logoColor=white)
![Tokyo Night](https://img.shields.io/badge/Theme-Tokyo_Night-7aa2f7?style=for-the-badge)

*Una configuración altamente personalizada y funcional para Arch Linux con Hyprland*

</div>

---

## 📸 Screenshot

> *(Agrega tu screenshot aquí — puedes arrastrarlo directamente a GitHub)*

---

## ⚡ Stack

| Componente | Herramienta |
|-----------|-------------|
| 🖥️ OS | Arch Linux |
| 🪟 Window Manager | Hyprland |
| 📊 Bar | Waybar |
| 🎨 Theme | Tokyo Night |
| 🖥️ Terminal | Ghostty |
| 🐚 Shell | Zsh |
| 📁 File Manager | Yazi |
| 🚀 Launcher | Wofi |
| 🔔 Notifications | Swaync |
| 🔒 Lock Screen | Hyprlock |
| 🖼️ Wallpaper | Swww + Waypaper |
| ✏️ Editor | Neovim |
| 📈 System Monitor | Btop |
| 🔍 Fetch | Fastfetch |

---

## ✨ Características

- 🎨 **Tema Tokyo Night** — consistente en toda la configuración
- 📦 **Waybar personalizado** — con módulos custom para Dropbox, red y batería
- 🖼️ **Wallpapers animados** — soporte para GIFs con transiciones suaves
- 🔒 **Pantalla de bloqueo** — con blur del wallpaper actual y reloj
- 📂 **Dotfiles organizados** — con symlinks para fácil mantenimiento
- ⌨️ **Atajos de teclado** — flujo de trabajo optimizado
- 🔔 **Notificaciones de batería** — alertas automáticas al 30%, 15% y 5%
- 🌐 **NetworkManager dmenu** — gestión de redes desde el teclado

---

## 🚀 Instalación

### Requisitos previos

```bash
sudo pacman -S git zsh
```

### Clonar el repositorio

```bash
git clone https://github.com/hufloig-wq/dotfiles.git ~/dev/config/dotfiles
```

### Instalar paquetes

```bash
# Paquetes oficiales
sudo pacman -S - < pkglist.txt

# Paquetes AUR
yay -S - < aur-pkglist.txt
```

### Crear symlinks

```bash
cd ~/dev/config/dotfiles
bash install.sh
```

---

## 📁 Estructura

```
dotfiles/
├── hypr/          # Hyprland, Hyprlock, Hyprpaper
├── waybar/        # Config, módulos, estilos y scripts
├── ghostty/       # Configuración del terminal
├── zsh/           # .zshrc y aliases
├── wofi/          # Lanzador de aplicaciones
├── yazi/          # File manager
├── fastfetch/     # Sistema fetch
├── btop/          # Monitor del sistema
├── nvim/          # Neovim
├── waypaper/      # Gestión de wallpapers
├── pkglist.txt    # Paquetes oficiales
└── aur-pkglist.txt # Paquetes AUR
```

---

## ⌨️ Atajos principales

| Atajo | Acción |
|-------|--------|
| `Super + Enter` | Abrir terminal |
| `Super + W` | Wallpaper aleatorio |
| `Super + Q` | Cerrar ventana |
| `Super + L` | Bloquear pantalla |
| `Super + D` | Lanzador de apps |
| `Super + J` | Toggle split |

---

<div align="center">

*Hecho con ❤️ por HprHufloig*

</div>
