# adding repos
sudo add-apt-repository -y ppa:neovim-ppa/unstable
sudo apt update

sudo apt install -y\
    curl apt-transport-https wget\
    lxpolkit picom i3 maim xclip feh rofi i3blocks xbacklight xss-lock\
    golang nodejs python3-venv\
    neovim git tmux\
    ripgrep todotxt-cli\
    sway swaylock swayidle waybar\
    foot\
    wl-clipboard cliphist\
    grim slurp\
    jq
sudo npm install -g tree-sitter-cli


# link config
ln -sf ~/.w/config/* ~/.config
ln -sf ~/.w/tmux.conf ~/.tmux.conf
ln -sf ~/.w/bashrc ~/.bashrc


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
sudo wget https://github.com/metwse/rofi-tdk.sh/releases/latest/download/rofi-tdk.tar.gz -O /var/rofi-tdk.tar.gz


# tmux
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm


# greenclip -- commented out since i switched to wayland
# sudo wget https://github.com/erebe/greenclip/releases/download/v4.2/greenclip -O /usr/bin/greenclip
# sudo chmod +x /usr/bin/greenclip


# keyboard layout
cd ~/.w/
sudo ln -f xkb /usr/share/X11/xkb/symbols/us
