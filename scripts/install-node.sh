#!/bin/bash
source ./config.sh

curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/${NVM_VERSION}/install.sh |
    bash

export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] &&
    printf %s "${HOME}/.nvm" ||
    printf %s "${XDG_CONFIG_HOME}/nvm")"

[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"

nvm install $NODE_VERSION
nvm use $NODE_VERSION

npm install -g $NODE_PACKAGES
