#!/bin/bash
source ./config.sh

mkdir -p ~/.tmux/plugins/
git clone --branch $TPM_VERSION \
    https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
