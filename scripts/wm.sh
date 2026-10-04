#!/bin/bash
source ./config.sh


# keyboard layout
sudo ln -f ../xkb /usr/share/X11/xkb/symbols/us


# fonts
cd /tmp/

wget https://github.com/ryanoasis/nerd-fonts/releases/download/$NERD_FONTS_VERSION/NerdFontsSymbolsOnly.zip \
    https://raw.githubusercontent.com/powerline/powerline/refs/tags/$POWERLINE_FONT_VERSION/font/10-powerline-symbols.conf \
    https://raw.githubusercontent.com/powerline/powerline/refs/tags/$POWERLINE_FONT_VERSION/font/PowerlineSymbols.otf

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
sudo wget https://github.com/erebe/greenclip/releases/download/$GREENCLIP_VERSION/greenclip \
    -O /usr/local/bin/greenclip
sudo chmod +x /usr/local/bin/greenclip
