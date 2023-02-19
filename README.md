# dotfiles

```
sudo sh -c "echo 'deb [signed-by=/usr/share/keyrings/packages-pgadmin-org.gpg] https://ftp.postgresql.org/pub/pgadmin/pgadmin4/apt/jammy pgadmin4 main' >> /etc/apt/sources.list.d/pgadmin4.list"
sudo sh -c "echo 'deb [signed-by=/usr/share/keyrings/nodesource.gpg] https://deb.nodesource.com/node_18.x jammy main\ndeb-src [signed-by=/usr/share/keyrings/nodesource.gpg] https://deb.nodesource.com/node_18.x jammy main' >> /etc/apt/sources.list.d/node.list"
sudo sh -c "echo 'deb https://ppa.launchpadcontent.net/neovim-ppa/unstable/ubuntu/ jammy main' >> /etc/apt/sources.list.d/nvim.list"
sudo sh -c "echo 'deb https://baltocdn.com/i3-window-manager/i3/i3-autobuild/ all main' >> /etc/apt/sources.list.d/i3.list"

sudo apt update

sudo apt install picom i3 maim nvim xdotol xclip feh git tmux

git clone --depth 1 https://github.com/wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/start/packer.nvim
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

cp -r ./.config/* ~/.config/
cp ./.tmux.conf ~/
cp ./.bashrc ~/

mkdir -p ~/Pictures
cp ./wallpaper.jpg ~/Pictures/
cp ./screensaver.png ~/Pictures/
```
