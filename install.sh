# adding repos
sudo add-apt-repository ppa:neovim-ppa/unstable
sudo apt update

sudo apt install\
    curl apt-transport-https wget\
    lxpolkit picom i3 maim xclip feh rofi i3blocks xbacklight xss-lock\
    neovim git tmux\
    golang nodejs\
    ripgrep todotxt-cli
sudo npm install -g tree-sitter-cli


# config
cp -r ./config/* ~/.config/
cp ./tmux.conf ~/.tmux.conf
cp ./bashrc ~/.bashrc


# fonts
cd /tmp
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/NerdFontsSymbolsOnly.zip https://github.com/Lokaltog/powerline/raw/develop/font/PowerlineSymbols.otf https://github.com/Lokaltog/powerline/raw/develop/font/10-powerline-symbols.conf
mkdir -p ~/.fonts/; mkdir -p ~/.config/fontconfig/conf.d/
unzip NerdFontsSymbolsOnly.zip
mv PowerlineSymbols.otf ~/.fonts/
mv 10-powerline-symbols.conf ~/.config/fontconfig/conf.d/
mv SymbolsNerdFont-Regular.ttf ~/.fonts/
mv SymbolsNerdFontMono-Regular.ttf ~/.fonts/
fc-cache -vf ~/.fonts


# rofi-tdk
sudo wget https://github.com/metwse/rofi-tdk.sh/releases/latest/download/rofi-tdk.tar.gz -O /var/rofi-tdk.tar.gz


# i3blocks
git clone --depth 1 https://github.com/wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/start/packer.nvim
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm


# greenclip
sudo wget https://github.com/erebe/greenclip/releases/download/v4.2/greenclip -O /usr/bin/greenclip
sudo chmod +x /usr/bin/greenclip
