FROM debian:13.5

# Install sudo
RUN apt-get update && apt-get install -y --no-install-recommends sudo tini

# Add a new user
RUN useradd -m -s /bin/bash metw && \
    usermod -aG sudo metw && \
    echo 'metw ALL=(ALL) NOPASSWD:ALL' > /etc/sudoers.d/metw && \
    chmod 0440 /etc/sudoers.d/metw

WORKDIR /home/metw

COPY --chown=metw:metw config/ .config/
COPY --chown=metw:metw tmux.conf .tmux.conf
COPY --chown=metw:metw docker/.bashrc .bashrc

COPY bashrc /tmp/.w/bashrc
COPY scripts/ /tmp/.w/scripts

USER metw

RUN cd /tmp/.w/scripts && \
    ./install-packages.sh dev && \
    ./install-node.sh && \
    ./install-neovim.sh && \
    ./install-tpm.sh
RUN cat /tmp/.w/bashrc >> .bashrc

RUN rustup toolchain install stable nightly --profile minimal && \
    rustup default stable && \
    rustup component add rust-analyzer --toolchain stable

# Install Neovim & tmux plugins
RUN NVIM_ENABLE_PLUGINS=1 nvim --headless '+Lazy! sync' +qa
RUN ~/.tmux/plugins/tpm/bindings/install_plugins; exit 0

RUN sudo rm -rf /var/lib/apt/lists/*

ENTRYPOINT ["/usr/bin/tini", "--"]
