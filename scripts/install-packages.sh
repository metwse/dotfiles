#!/bin/bash
source ./config.sh

if [ "${1:-}" == 'dev' ]; then
    PACKAGES=("${DEV_PACKAGES[@]}")
else
    PACKAGES=("${DEV_PACKAGES[@]}" "${DESKTOP_PACKAGES[@]}")
fi

sudo apt update
sudo apt install -y --no-install-recommends "${PACKAGES[@]}"
