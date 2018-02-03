APP := prometheus
VERSION := 2.1.0
ARCH := arm64
OS := linux

.PHONY: help docker
.DEFAULT_GOAL := help

docker: download ## Create docker image
	docker build -t otomarukanta/$(APP)-$(ARCH):v$(VERSION) .

docker-push: ## Publish image on docker hub
	docker push otomarukanta/$(APP)-$(ARCH):v$(VERSION)

download:
	mkdir download
	curl -L https://github.com/prometheus/$(APP)/releases/download/v$(VERSION)/$(APP)-$(VERSION).$(OS)-$(ARCH).tar.gz | tar xvz -C download --strip-components 1

clean: ## Remove build artifacts
	rm -r download || true

help: ## Print available commands
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
