<img align="right" height="320"
  src="https://imgs.xkcd.com/comics/workflow.png" />

# dotfiles

One step installation:
```sh
git clone --recurse-submodules https://github.com/metwse/dotfiles ~/.w && \
    cd ~/.w && \
    ./install.sh
```

I use Debian 13 with Gnome & Cinnamon installed. This configuration also tested
on Linux Mint 22.


## Dockerized Setup

You can use a Dockerized version of this configuration. Use
```sh
docker build -t metw .
```
to build the image,
```sh
docker run --name container-name -d metw sleep infinity
```
to start a container, and
```sh
docker exec -e TERM="$TERM" -u metw -it container-name bash
```
to connect the shell of it.
