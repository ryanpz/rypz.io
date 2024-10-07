include .env

CONTAINER_RUNNER ?= podman
ZOLA_VERSION ?= v0.19.2
SERVE_PORT ?= 8085

.PHONY: build
build:
	$(CONTAINER_RUNNER) run \
		--security-opt label:disable \
		-v $(shell pwd):/app \
		--workdir /app \
		ghcr.io/getzola/zola:$(ZOLA_VERSION) \
		build

.PHONY: serve
serve:
	$(CONTAINER_RUNNER) run \
		--security-opt label:disable \
		-v $(shell pwd):/app \
		--workdir /app \
		-p $(SERVE_PORT):$(SERVE_PORT) \
		-p 1024:1024 \
		ghcr.io/getzola/zola:$(ZOLA_VERSION) \
		serve \
		--interface 0.0.0.0 \
		--port $(SERVE_PORT) \
		--base-url 0.0.0.0
