build: clean
	docker volume create wuelner-nvim-config
	docker volume create wuelner-nvim-store
	docker build . -t wuelner-nvim
	docker container create -v wuelner-nvim-config:/data --name tmp busybox
	docker cp . tmp:/data
	docker rm tmp
	docker run --rm -v wuelner-nvim-store:/root/.local/share/nvim wuelner-nvim git clone --filter=blob:none https://github.com/folke/lazy.nvim.git /root/.local/share/nvim/lazy/lazy.nvim

clean::
	unlink ~/.local/bin/wnvim || true
	docker volume rm wuelner-nvim-config || true
	docker volume rm wuelner-nvim-store || true

install::
	ln -s $(shell pwd)/wnvim ~/.local/bin/.
