#!/bin/bash
cd scripts/

./install-packages.sh
./install-tmp.sh
./wm.sh


# link config
mkdir -p ~/.config/
ln -sf $PWD/config/* ~/.config
ln -sf $PWD/tmux.conf ~/.tmux.conf

echo "source $PWD/bashrc" >> ~/.bashrc
