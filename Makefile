DEPS         = Dockerfile .dockerignore buttersinkstrap
DOCKER_IMAGE = flungo/buttersink
SCRIPT       = $(abspath ./buttersink)
INSTALL      = /usr/local/bin/buttersink

.build: $(DEPS)
	docker build -t $(DOCKER_IMAGE) .
	touch $@

.PHONY: build push

build: .build

push: build
	docker push $(DOCKER_IMAGE)

.PHONY: install uninstall

$(INSTALL): $(SCRIPT)
	ln -s $(SCRIPT) $(INSTALL)

install: .build uninstall $(INSTALL)

uninstall:
	rm -f $(INSTALL)
