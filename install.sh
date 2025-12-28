sudo add-apt-repository -y ppa:neovim-ppa/unstable  # Daily builds of nvim

sudo apt update

packages=(
    apt-transport-https wget curl  # networking
    i3 lxpolkit picom xbacklight xss-lock  # window manager (X11)
    sway swaylock swayidle waybar  # window manager (Wayland)
    maim xclip feh i3blocks  # X11 utilities
    wl-clipboard cliphist grim slurp  # Wayland utilities
    foot  # Wayland terminal
    neovim git tmux  # core dev tools
    ripgrep todotxt-cli fzf  # CLI tools
    golang rustup python3-venv  # languages
    jq yq  # JSON/YAML utilities
    clang clangd  # C
    manpages manpages-dev manpages-posix manpages-posix-dev  # manpages
)

sudo apt install -y "${packages[@]}"


# link config
ln -sf ~/.w/config/* ~/.config
ln -sf ~/.w/tmux.conf ~/.tmux.conf

echo "source ~/.w/bashrc" >> ~/.bashrc


# install node & npm
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/master/install.sh | bash

export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

nvm install --lts
nvm use --lts

npm install -g tree-sitter-cli


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


# tmux
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm


# greenclip
sudo wget https://github.com/erebe/greenclip/releases/download/v4.2/greenclip \
    -O /usr/bin/greenclip
sudo chmod +x /usr/bin/greenclip


# keyboard layout
cd ~/.w/
sudo ln -f xkb /usr/share/X11/xkb/symbols/us
