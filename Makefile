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

DOCKER_IMAGE=theroozbeh/mermaid:latest
# DOCKER_IMAGE=mermaid:local

CMD=docker run --rm -v `pwd`:/data:z -u `id -u` $(DOCKER_IMAGE)

clean:
	rm -f *.pdf *.png
	
png:
	$(MAKE) _gen OUTPUT_EXT=png

pdf: 
	$(MAKE) _gen OUTPUT_EXT=pdf

publish:
	@mkdir -p $(PUBLISHED_DIR)
	@for ext in png pdf; do \
		if [ -e "$(MMD_DOC).$$ext" ]; then \
			mv $(MMD_DOC).$$ext published/$(MMD_DOC)-$(TIME_STAMP).$$ext; \
		fi; \
	done

info: 
	$(CMD) -p /puppeteer-config.json --version

_gen: _mermaid open

_mermaid: 
	$(CMD) -p /puppeteer-config.json -i $(MMD_DOC).mmd -o $(MMD_DOC).$(OUTPUT_EXT) -C mermaid.css 
