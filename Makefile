os ?= $(shell lsb_release -cs)	
install-docker:;: '$(os)'
	@apt-get update
	@apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common -y
	@curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
	@apt-key fingerprint 0EBFCD88
	@add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(os) stable"
	@apt-get update
	@apt-get install docker-ce -y
	@systemctl restart docker
	@systemctl enable docker
	@systemctl start docker

port-portainer ?= 9000:9000
install-portainer:;: '$(port-portainer)'
	@docker volume create portainer_data
	@docker run -d --name Portainer --restart=always -p $(port-portainer) -v /var/run/docker.sock:/var/run/docker.sock -v vol-portainer:/data portainer/portainer-ce

install-docker-compose:;:
	@sudo curl -L https://github.com/docker/compose/releases/download/1.20.1/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose
	@sudo chmod +x /usr/local/bin/docker-compose
	@sudo docker-compose --version
