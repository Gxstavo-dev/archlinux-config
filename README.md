# Arch Linux Config — Dotfiles

Respaldo de la configuración de mi instalación de Arch Linux (Hyprland).

## Qué incluye

| Ruta | Contenido |
|---|---|
| `config/hypr` | Configuración del compositor Hyprland en Lua (keybinds, monitor, animaciones, hyprglass) |
| `config/waybar` | Barra superior waybar |
| `config/rofi` | Launchers, powermenu, applets y temas |
| `config/networkmanager-dmenu` | Menú de red NetworkManager |
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

### Método automático (recomendado)

```bash
git clone https://github.com/Gxstavo-dev/archlinux-config.git ~/archlinux-config
cd ~/archlinux-config
chmod +x setup.sh
./setup.sh
```

El script `setup.sh`:

1. Instala **todos** los paquetes del sistema desde `pkglist.txt` (75 oficiales) y `aurlist.txt` (9 AUR) — fallback a una lista mínima si no existen
2. Hace respaldo de tu configuración actual en `~/.config.bak-<fecha>`
3. Copia los `config/*` a `~/.config/` y los `dotfiles/*` a tu home
4. Recarga Hyprland si está corriendo

> `pkglist.txt` y `aurlist.txt` se generan con `pacman -Qe` y `pacman -Qm`. Para actualizarlos tras instalar algo nuevo:
>
> ```bash
> cd ~/archlinux-config
> pacman -Qe | awk '{print $1}' > pkglist.txt
> pacman -Qm | awk '{print $1}' > aurlist.txt
> git add -A && git commit -m "update packages" && git push
> ```

Si no tienes `yay`, instálalo primero: https://github.com/Jguer/yay

### Método manual

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
sudo pacman -S hyprland waybar rofi swaybg gtk-engine-murrine
```

Ajusta la lista a tu distribución/gestor de paquetes.
