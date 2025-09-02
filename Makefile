-include .env.public
-include .env

ZINE_VERSION ?= 0.11.1
SERVE_PORT ?= 8085

ARCH := $(shell uname -m)
ifeq ($(ARCH), arm64)
	ARCH := aarch64
endif

OS := $(shell uname | tr '[:upper:]' '[:lower:]')
ifeq ($(OS), linux)
	OS := linux-musl
endif

ZINE_URL = https://github.com/kristoff-it/zine/releases/download/v$(ZINE_VERSION)/$(ARCH)-$(OS).tar.xz
TOOLS_DIR := tools
ZINE := $(TOOLS_DIR)/zine

WOODS_DIR := content/woods

.PHONY: serve
serve: $(ZINE)
	$(ZINE) --port $(SERVE_PORT) --drafts

.PHONY: build
build: $(ZINE)
	rm -rf public
	$(ZINE) release

$(ZINE):
	mkdir -p $(TOOLS_DIR)
	curl -Lo $(TOOLS_DIR)/zine.tar.xz $(ZINE_URL)
	tar -xvf $(TOOLS_DIR)/zine.tar.xz -C $(TOOLS_DIR)
	rm -rf $(TOOLS_DIR)/zine.tar.xz

post:
	WOODS_DIR=$(WOODS_DIR) $(TOOLS_DIR)/create-post

.PHONY: clean
clean:
	rm -rf public tools/zine* content/woods/new-post*
