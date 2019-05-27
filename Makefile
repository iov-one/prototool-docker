DOCKER_IMAGE:=iov1/prototool

build:
	@docker build --rm -t $(DOCKER_IMAGE) .

