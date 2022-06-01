# Mermaid Diagram Example

## TL;DR
1. Make sure you have docker and GNU Make installed. 
2. Modify the sequence diagaram `example.mmd` to your needs. 
3. Run `make pdf` or `make png` to build the diagram. 

## Mermaid

[Mermaid](https://mermaid-js.github.io/mermaid/#/) offers generation of diagrams and flowcharts from text in a similar manner as markdown.

The [example.mmd](example.mmd) file here is a simple sequence diagaram. You can read more about making sequence diagrams in Mermaid [here](https://mermaid-js.github.io/mermaid/#/sequenceDiagram).

## Makefile

In order to remove the need to install any tools and packages, the [Makefile](Makefile) is using the [official Docker image](https://hub.docker.com/r/minlag/mermaid-cli) to build PDF and PNG diagrams.

### Requirements
- Docker
- GNU Make 

### Makefile Targets
* `png` or `pdf`: compiles a PNG or PDF image from the first Mermaid file (the first result of `ls *.mdd`)
* `publish`: tags any existing PNG or PDF file with a timestamp and moves them under a `published` directory
* `clean`: removes the existing PDF and PNG files
