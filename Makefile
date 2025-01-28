MODULE = $(notdir $(CURDIR))

# version
GO_VER = 1.23.5
GO_GZ  = go$(GO_VER).linux-amd64.tar.gz
GO_URL = http://go.dev/dl

# dir
CWD    = $(CURDIR)
DISTR  = $(HOME)/distr
GOROOT = /usr/local/go
GO     = $(GOROOT)/bin/go
X      = $(CWD)/x/examples

# tool
CURL = curl -L -o
GO   = $(GOROOT)/bin/go
CLI  = $(HOME)/bin/outline-cli

CLI = $(HOME)/bin/outline-cli 
SRC = x/examples/outline-cli

G += $(wildcard $(SRC)/*.go)

.PHONY: all
all: $(CLI)
	$^ -transport

$(CLI): $(GO)
	cd $(X) ; go build -o $@  -ldflags="-extldflags=-static" ./outline-cli

# $(CLI): Makefile $(G)

# doc
# https://github.com/Jigsaw-Code/outline-sdk/issues/194

# install
$(GO): $(DISTR)/Linux/$(GO_GZ)
	sudo apt purge -y golang* ; sudo rm -rf $(GOROOT)
	sudo tar -C /usr/local -xzf $<
	sudo touch $@
	$(MAKE) $(HOME)/.setenv

.PHONY: $(HOME)/.setenv
$(HOME)/.setenv:
	echo '\n# Go' >> $@
	echo 'export GOROOT=$(GOROOT)' >> $@
	echo 'export PATH=$$GOROOT/bin:$$PATH' >> $@
	echo '# export GOPATH=$$HOME/$(MODULE)' >> $@
	. $@

$(DISTR)/Linux/$(GO_GZ):
	$(CURL) $@ $(GO_URL)/$(GO_GZ)
