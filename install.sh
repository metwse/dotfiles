#!/bin/bash


# link config
mkdir -p ~/.config/
ln -sf $PWD/config/* ~/.config
ln -sf $PWD/tmux.conf ~/.tmux.conf

echo "source $PWD/bashrc" >> ~/.bashrc


# install the packages
cd scripts/

./install-packages.sh
./install-tmp.sh
./wm.sh
