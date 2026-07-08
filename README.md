<img align="right" height="320"
  src="https://imgs.xkcd.com/comics/workflow.png" />

# dotfiles

One step installation:
```sh
git clone --recurse-submodules https://github.com/metwse/dotfiles ~/.w && \
    cd ~/.w && \
    ./install.sh
```


## Dockerized Setup

You can use a Dockerized version of this configuration. Use
```sh
docker build -t metw .
```
to build the image,
```sh
docker run --name metw metw sleep infinity
```
to start a container, and
```sh
docker exec -e TERM="$TERM" -u metw -it metw bash
```
to connect the shell of it.
