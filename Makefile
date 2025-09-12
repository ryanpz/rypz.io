-include .env.public
-include .env

ZINE_VERSION ?= 0.11.1
SERVE_PORT ?= 8085

ARCH := $(shell uname -m)
ifeq ($(ARCH), arm64)
	ARCH := aarch64
endif

OS := $(shell uname | tr '[:upper:]' '[:lower:]')
ARCHIVE_EXT := .tar.xz
ifeq ($(OS), linux)
	OS := linux-musl
else ifeq ($(OS), darwin)
	OS := macos
	ARCHIVE_EXT := .zip
endif

ZINE_URL = https://github.com/kristoff-it/zine/releases/download/v$(ZINE_VERSION)/$(ARCH)-$(OS)$(ARCHIVE_EXT)

TOOLS_DIR := tools
ZINE_ARCHIVE := $(TOOLS_DIR)/zine$(ARCHIVE_EXT)
ZINE := $(TOOLS_DIR)/zine

EXTRACT_CMD := tar -C $(TOOLS_DIR) -xvf
ifeq ($(ARCHIVE_EXT), .zip)
	EXTRACT_CMD := unzip -d $(TOOLS_DIR)
endif

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
	curl -Lo $(ZINE_ARCHIVE) $(ZINE_URL)
	$(EXTRACT_CMD) $(ZINE_ARCHIVE)
	rm -rf $(ZINE_ARCHIVE)

post:
	WOODS_DIR=$(WOODS_DIR) $(TOOLS_DIR)/create-post

.PHONY: clean
clean:
	rm -rf public tools/zine* content/woods/new-post*
