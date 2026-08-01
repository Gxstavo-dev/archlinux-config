#!/usr/bin/env bash
#
# setup.sh — Restaura la configuración de Arch Linux desde este repo
#
# Instala las dependencias (pacman + AUR) y copia los dotfiles/configs.
# Hace respaldo de la configuración existente antes de sobrescribir.
#
# Uso:  ./setup.sh   (o:  bash setup.sh)
#

set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BACKUP_DIR="$HOME/.config.bak-$(date +%Y%m%d-%H%M%S)"

# Paquetes de los repos oficiales
PACMAN_PKGS=(
    hyprland
    swaybg
    rofi
    neovim
    ghostty
    kitty
    dolphin
    mpv
    btop
    playerctl
    brightnessctl
    pipewire
    pipewire-pulse
    wireplumber
    gtk-engine-murrine
)

# Paquetes de AUR (via yay)
AUR_PKGS=(
    quickshell
    brave-bin
)

info()  { echo -e "\e[1;36m[setup]\e[0m $*"; }
warn()  { echo -e "\e[1;33m[setup]\e[0m $*"; }
fail()  { echo -e "\e[1;31m[setup]\e[0m $*" >&2; exit 1; }

# 0. Requisitos
command -v pacman >/dev/null || fail "Esto es para Arch Linux (no se encontró pacman)."
command -v yay >/dev/null || warn "yay no está instalado, se omitirán los paquetes de AUR."

# 1. Instalar dependencias
info "Instalando paquetes de los repos oficiales..."
sudo pacman -S --needed --noconfirm "${PACMAN_PKGS[@]}"

if command -v yay >/dev/null; then
    info "Instalando paquetes de AUR..."
    yay -S --needed --noconfirm "${AUR_PKGS[@]}"
else
    warn "Saltando AUR: instala yay primero (https://github.com/Jguer/yay)."
    warn "Paquetes omitidos: ${AUR_PKGS[*]}"
fi

# 2. Respaldar configuración existente
info "Respaldo de config actual en: $BACKUP_DIR"
mkdir -p "$BACKUP_DIR"

for dir in config/*/; do
    name="$(basename "$dir")"
    [ -e "$HOME/.config/$name" ] && cp -r "$HOME/.config/$name" "$BACKUP_DIR/"
done
for f in dotfiles/*; do
    name="$(basename "$f")"
    [ -e "$HOME/.$name" ] && cp "$HOME/.$name" "$BACKUP_DIR/" 2>/dev/null || true
done

# 3. Copiar configuración nueva
info "Copiando configuración..."
mkdir -p "$HOME/.config"
for dir in config/*/; do
    name="$(basename "$dir")"
    cp -r "$dir" "$HOME/.config/$name"
    info "  ~/.config/$name"
done

info "Copiando dotfiles..."
for f in dotfiles/*; do
    name="$(basename "$f")"
    cp "$f" "$HOME/.$name"
    info "  ~/.$name"
done

# 4. Recargar Hyprland si está corriendo
if pgrep -x Hyprland >/dev/null 2>&1; then
    info "Hyprland detectado, recargando..."
    hyprctl reload >/dev/null 2>&1 || true
fi

info "Listo. Si algo no aplica, reinicia sesión."
info "Respaldo anterior en: $BACKUP_DIR"
