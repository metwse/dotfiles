# adding repos
sudo apt update
sudo apt install curl
curl https://baltocdn.com/i3-window-manager/signing.asc | sudo apt-key add -
sudo apt install apt-transport-https --yes

sudo add-apt-repository ppa:neovim-ppa/unstable
sudo sh -c "echo 'deb [signed-by=/usr/share/keyrings/packages-pgadmin-org.gpg] https://ftp.postgresql.org/pub/pgadmin/pgadmin4/apt/jammy pgadmin4 main' >> /etc/apt/sources.list.d/pgadmin4.list"
sudo sh -c "echo 'deb [signed-by=/usr/share/keyrings/nodesource.gpg] https://deb.nodesource.com/node_18.x jammy main\ndeb-src [signed-by=/usr/share/keyrings/nodesource.gpg] https://deb.nodesource.com/node_18.x jammy main' >> /etc/apt/sources.list.d/node.list"
sudo sh -c "echo 'deb https://baltocdn.com/i3-window-manager/i3/i3-autobuild/ all main' >> /etc/apt/sources.list.d/i3.list"

sudo apt update

sudo apt install lxpolkit picom i3 maim neovim xclip feh git tmux golang nodejs wget rofi i3blocks xbacklight surf golang
sudo npm install -g tree-sitter-cli


# config
git clone --depth 1 https://github.com/wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/start/packer.nvim
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

cp -r ./.config/* ~/.config/
cp ./.tmux.conf ~/
cp ./.bashrc ~/


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


# i3blocks
git clone https://github.com/vivien/i3blocks-contrib ~/.config/i3blocks/scripts


# xwinwrap
cd /tmp/
sudo apt-get install xorg-dev build-essential libx11-dev x11proto-xext-dev libxrender-dev libxext-dev
git clone https://github.com/mmhobi7/xwinwrap.git
cd xwinwrap
make
sudo make install
make clean
cd /tmp/
rm xwinwrap


# greenclip
sudo wget https://github.com/erebe/greenclip/releases/download/v4.2/greenclip -O /usr/bin/greenclip
sudo chmod +x /usr/bin/greenclip


# surf browser permission
echo '@{HOME}/.config/i3/wallpaper/** r,' | sudo tee -a /etc/apparmor.d/usr.bin.surf
sudo nvim -c $ /etc/apparmor.d/usr.bin.surf
sudo apparmor_parser -r /etc/apparmor.d/usr.bin.surf
