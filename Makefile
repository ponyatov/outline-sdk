# version
GO_VER = 1.23.5
GO_GZ  = go$(GO_VER).linux-amd64.tar.gz
GO_URL = http://go.dev/dl

# dir
DISTR  = $(HOME)/distr
GOROOT = /usr/local/go
GO     = $(GOROOT)/bin/go

# tool
CURL = curl -L -o
GO   = $(GOROOT)/bin/go

CLI = $(HOME)/bin/outline-cli 
SRC = x/examples/outline-cli

G += $(wildcard $(SRC)/*.go)

.PHONY: all
all: $(GO)
	echo '\n# Go' >> ~/.setenv
	echo 'export PATH=$(GOROOT)/bin:$$PATH' >> ~/.setenv

$(CLI): Makefile $(G)
	cd $(SRC) ; go build -o $@  -ldflags="-extldflags=-static" .

# doc
# https://github.com/Jigsaw-Code/outline-sdk/issues/194

# install
$(GO): $(DISTR)/Linux/$(GO_GZ)
	sudo apt purge -y golang* ; sudo rm -rf $(GOROOT)
	sudo tar -C /usr/local -xzf $<
	sudo touch $@

$(DISTR)/Linux/$(GO_GZ):
	$(CURL) $@ $(GO_URL)/$(GO_GZ)
