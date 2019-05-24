DOCKER_IMAGE:=iov1/prototool-docker

build:
	@docker build --rm -t $(DOCKER_IMAGE) .

