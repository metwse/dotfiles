#!/bin/bash
set -euo pipefail

export DEV_PACKAGES=(
    apt-transport-https wget curl  # networking
    git tmux  # core dev tools
    ripgrep todotxt-cli fzf unzip  # CLI tools
    golang rustup python3-venv  # languages
    jq yq  # JSON/YAML utilities
    clang clangd valgrind build-essential pkg-config  # build tools
    manpages manpages-dev  # manpages
)
export DESKTOP_PACKAGES=(
    i3 lxpolkit picom xbacklight xss-lock  # window manager (X11)
    sway swaylock swayidle waybar  # window manager (Wayland)
    maim xclip feh i3blocks  # X11 utilities
    wl-clipboard cliphist grim slurp  # Wayland utilities
    foot  # Wayland terminal
)
export NODE_PACKAGES=(
    tree-sitter-cli
)

export NVIM_VERSION=v0.12.3
export NVM_VERSION=v0.40.3
export NODE_VERSION=v24.18.0
export TPM_VERSION=v3.1.0
export GREENCLIP_VERSION=v4.2
export NERD_FONTS_VERSION=v3.0.2
export POWERLINE_FONT_VERSION=2.8.4
