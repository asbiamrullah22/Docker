os ?= $(shell lsb_release -cs)	
install-docker:;: '$(os)'
	@apt-get update
	@apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common
	@curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
	@apt-key fingerprint 0EBFCD88
	@add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(os) stable"
	@apt-get update
	@apt-get install docker-ce -y
	@apt-cache madison docker-ce
