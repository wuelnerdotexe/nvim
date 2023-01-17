#! /usr/bin/env bash

docker volume create nvim-config
docker volume create nvim-store

docker build . -t wuelner-nvim

docker container create -v nvim-config:/data --name tmp busybox
docker cp . tmp:/data
docker rm tmp

docker run --rm -v nvim-store:/root/.local/share/nvim wuelner-nvim git clone --depth 1 https://github.com/wbthomason/packer.nvim /root/.local/share/nvim/site/pack/packer/start/packer.nvim
