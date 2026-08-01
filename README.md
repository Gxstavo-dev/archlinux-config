# Arch Linux Config — Dotfiles

Respaldo de la configuración de mi instalación de Arch Linux (Hyprland).

## Qué incluye

| Ruta | Contenido |
|---|---|
| `config/hypr` | Configuración del compositor Hyprland (keybinds, monitor, animaciones) |
| `config/nvim` | Configuración de Neovim |
| `config/ghostty` | Terminal Ghostty |
| `config/mpv` | Config de mpv |
| `config/btop` | Monitor de sistema btop |
| `config/gtk-3.0` y `config/gtk-4.0` | Temas GTK |
| `config/yay` | Config de yay (AUR helper) |
| `config/mimeapps.list` | Aplicaciones por defecto |
| `dotfiles/bashrc` | Mi `.bashrc` |
| `dotfiles/bash_profile` | Mi `.bash_profile` |
| `dotfiles/profile` | Mi `.profile` |

## Qué NO incluye (a propósito)

Archivos con secretos o información sensible:
- `.ssh`, `.gnupg`, claves y tokens de GitHub/API
- Configuraciones con credenciales: `gh`, `turso`, `ngrok`, `stripe`, `cursor`, `opencode`, `mozilla`, `.npmrc`
- Bases de datos locales y datos personales

Revisa con `grep -rniE "api[_-]?key|secret|token|passw" config/` antes de usar cualquier copia si modificas este repo.

## Cómo restaurar

### 1. Clonar el repo

```bash
git clone https://github.com/Gxstavo-dev/archlinux-config.git ~/archlinux-config
cd ~/archlinux-config
```

### 2. Copiar la configuración

```bash
# Configs de ~/.config
cp -r config/* ~/.config/

# Dotfiles del home
cp dotfiles/bashrc ~/.bashrc
cp dotfiles/bash_profile ~/.bash_profile
cp dotfiles/profile ~/.profile
```

> **Nota:** para que los cambios de Hyprland surtan efecto, reinicia el compositor (por ejemplo `hyprctl reload` para Hyprland) o vuelve a iniciar sesión.

### 3. Dependencias

Instala primero los paquetes que usan estas configs (ejemplo):

```bash
sudo pacman -S hyprland quickshell rofi neovim ghostty mpv btop gtk-engine-murrine
yay -S swaybg  # o el paquete que uses para el fondo de pantalla
```

Ajusta la lista a tu distribución/gestor de paquetes.
