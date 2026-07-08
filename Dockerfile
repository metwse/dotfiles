FROM debian:13.5

# Install sudo
RUN apt-get update && apt-get install -y --no-install-recommends sudo tini \
    && rm -rf /var/lib/apt/lists/*

# Add a new user
RUN useradd -m -s /bin/bash metw && \
    usermod -aG sudo metw && \
    echo 'metw ALL=(ALL) NOPASSWD:ALL' > /etc/sudoers.d/metw && \
    chmod 0440 /etc/sudoers.d/metw

WORKDIR /home/metw

COPY --chown=metw:metw ./config/ .w/config/
COPY --chown=metw:metw ./docker/ .w/docker/
COPY --chown=metw:metw ./tmux.conf .w/tmux.conf
COPY --chown=metw:metw ./bashrc .w/bashrc
COPY ./install.sh .w/install.sh

USER metw

# Install the development setup
RUN mkdir -p .config && \
    cp .w/docker/.bashrc ./ && \
    cd .w && ./install.sh dev

RUN rustup toolchain install stable nightly --profile minimal && \
    rustup default stable && \
    rustup component add rust-analyzer --toolchain stable

ENTRYPOINT ["/usr/bin/tini", "--"]
