#!/bin/bash
source ./config.sh

wget https://github.com/neovim/neovim/releases/download/$NVIM_VERSION/nvim-linux-x86_64.tar.gz \
    -O /tmp/nvim.tar.gz

tar -xzf /tmp/nvim.tar.gz -C /tmp/

sudo mv /tmp/nvim-linux-x86_64/ /opt/

sudo ln -s /opt/nvim-linux-x86_64/bin/nvim /usr/local/bin/nvim
