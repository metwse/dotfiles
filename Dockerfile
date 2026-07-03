FROM debian:13.5

# Install sudo
RUN apt-get update && apt-get install -y --no-install-recommends \
    sudo \
    && rm -rf /var/lib/apt/lists/*

# Add a new user
RUN useradd -m -s /bin/bash metw && \
    usermod -aG sudo metw && \
    echo 'metw ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers

WORKDIR /home/metw

COPY --chown=metw:metw . .w/

USER metw

# Install the development setup
RUN mkdir -p .config && \
    cp .w/docker/.bashrc ./ && \
    cd .w && ./install.sh dev

RUN rustup install stable && \
    rustup install nightly && \
    rustup component add rust-analyzer

CMD while true; do sleep 3600; done
