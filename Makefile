#
# Makefile for building Mermaid diagrams
#

SHELL := /bin/bash

.DEFAULT_GOAL := pdf
.PHONY: clean png pdf publish open info _gen _mermaid

PUBLISHED_DIR=published
OUTPUT_EXT ?= pdf
MMD_DOC_FILE=$(shell ls *.mmd | head -n 1)
MMD_DOC ?= $(MMD_DOC_FILE:.mmd=)

TIME_STAMP=$(shell date +"%y%m%d-%H%M")

DOCKER_IMAGE=minlag/mermaid-cli:latest
# Deprecated: 
# DOCKER_IMAGE=theroozbeh/mermaid:latest

CMD=docker run --rm -v `pwd`:/data:z -u `id -u` $(DOCKER_IMAGE)

clean:
	rm -f *.pdf *.png
	
png:
	@$(MAKE) _gen OUTPUT_EXT=png

pdf: 
	@$(MAKE) _gen OUTPUT_EXT=pdf

publish:
	@mkdir -p $(PUBLISHED_DIR)
	@for ext in png pdf; do \
		if [ -e "$(MMD_DOC).$$ext" ]; then \
			mv $(MMD_DOC).$$ext published/$(MMD_DOC)-$(TIME_STAMP).$$ext; \
		fi; \
	done

info:
	@echo Using $(DOCKER_IMAGE)
	@$(CMD) --version

_gen: _mermaid

_mermaid: 
	@$(CMD) -i /data/$(MMD_DOC).mmd -o /data/$(MMD_DOC).$(OUTPUT_EXT) -C /data/mermaid.css 
