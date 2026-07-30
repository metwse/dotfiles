#!/bin/bash
set -euo pipefail

dev_packages=(
    apt-transport-https wget curl  # networking
    git tmux  # core dev tools
    ripgrep todotxt-cli fzf unzip  # CLI tools
    golang rustup python3-venv  # languages
    jq yq  # JSON/YAML utilities
    clang clangd  # C
)

desktop_packages=(
    i3 lxpolkit picom xbacklight xss-lock  # window manager (X11)
    sway swaylock swayidle waybar  # window manager (Wayland)
    maim xclip feh i3blocks  # X11 utilities
    wl-clipboard cliphist grim slurp  # Wayland utilities
    foot  # Wayland terminal
    manpages manpages-dev manpages-posix manpages-posix-dev  # manpages
)

if [ "${1:-}" == 'dev' ]; then
    packages=("${dev_packages[@]}")
else
    packages=("${dev_packages[@]}" "${desktop_packages[@]}")
fi

sudo apt update
sudo apt install -y --no-install-recommends "${packages[@]}"


NVIM_VERSION="v0.12.3"
NVM_VERSION="v0.40.3"
NODE_VERSION="v24.18.0"
TPM_VERSION="v3.1.0"

# neovim
wget https://github.com/neovim/neovim/releases/download/$NVIM_VERSION/nvim-linux-x86_64.tar.gz \
    -O /tmp/nvim.tar.gz
tar -xzf /tmp/nvim.tar.gz -C /tmp/
sudo mv /tmp/nvim-linux-x86_64/ /opt/
sudo ln -s /opt/nvim-linux-x86_64/bin/nvim /usr/local/bin/nvim

# install node & npm
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/${NVM_VERSION}/install.sh |
    bash

export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] &&
    printf %s "${HOME}/.nvm" ||
    printf %s "${XDG_CONFIG_HOME}/nvm")"

[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"

nvm install $NODE_VERSION
nvm use $NODE_VERSION

npm install -g tree-sitter-cli

# tmux package manager
mkdir -p ~/.tmux/plugins/
git clone --branch $TPM_VERSION \
    https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm


# link config
mkdir -p ~/.config/
ln -sf ~/.w/config/* ~/.config
ln -sf ~/.w/tmux.conf ~/.tmux.conf

echo "source ~/.w/bashrc" >> ~/.bashrc


# Development environment setup ends here.
[ "$1" == 'dev' ] && exit 0


# fonts
cd /tmp/

wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/NerdFontsSymbolsOnly.zip \
    https://github.com/Lokaltog/powerline/raw/develop/font/PowerlineSymbols.otf \
    https://github.com/Lokaltog/powerline/raw/develop/font/10-powerline-symbols.conf

mkdir -p ~/.fonts/
mkdir -p ~/.config/fontconfig/conf.d/

unzip NerdFontsSymbolsOnly.zip
mv PowerlineSymbols.otf ~/.fonts/
mv 10-powerline-symbols.conf ~/.config/fontconfig/conf.d/
mv SymbolsNerdFont-Regular.ttf ~/.fonts/
mv SymbolsNerdFontMono-Regular.ttf ~/.fonts/
fc-cache -vf ~/.fonts


# rofi-tdk
sudo wget \
    https://github.com/metwse/rofi-tdk.sh/releases/latest/download/rofi-tdk.tar.gz \
    -O /var/rofi-tdk.tar.gz


# greenclip
sudo wget https://github.com/erebe/greenclip/releases/download/v4.2/greenclip \
    -O /usr/local/bin/greenclip
sudo chmod +x /usr/local/bin/greenclip


# keyboard layout
cd ~/.w/
sudo ln -f xkb /usr/share/X11/xkb/symbols/us
