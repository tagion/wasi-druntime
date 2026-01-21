# tools director
TOOLS:=$(abspath $(REPOROOT)/tools)
LDC_VERSION?=1.41.0
DLANG:=$(TOOLS)/dlang
DLANG_INSTALL:=$(DLANG)/install.sh 
DLANG_INSTALL_URL:=https://dlang.org/install.sh
LDC_NAME:=ldc-$(LDC_VERSION)
DLANG_PATH=$(HOME)/dlang/$(LDC_NAME)
LDC_BIN:=$(DLANG_PATH)/bin
LDC_WASI:=$(LDC_BIN)/ldc2

$(DLANG_INSTALL):
	$(PRECMD)
	$(MKDIR) -p $(DLANG)
	wget $(DLANG_INSTALL_URL) -O $@
	chmod 750 $@


$(DLANG_PATH): $(DLANG_INSTALL)
	$(PRECMD)
	$(DLANG_INSTALL) install $(LDC_NAME)

install-dlang: $(DLANG_PATH)

ifdef DONT
LDC_HOST:=ldc2-${LDC_VERSION}-linux-x86_64
LDC_HOST_TAR:=$(LDC_HOST).tar.xz
LDC_WASI_BIN:=$(TOOLS)/$(LDC_HOST)/bin
LDC_WASI:=$(LDC_WASI_BIN)/ldc2
LDC_URL:=https://github.com/ldc-developers/ldc/releases/download/v${LDC_VERSION}
LDC_URL_TAR:=$(LDC_URL)/${LDC_HOST_TAR}

export DC=$(LDC_WASI)

install-wasi-wasm-toolchain: $(LDC_HOST) 
.PHONY: install-wasi-wasm-toolchain

$(TOOLS)/.way:
	mkdir -p $(TOOLS)
	touch $(TOOLS)/.way

$(TOOLS)/$(LDC_HOST)/etc/ldc2.conf: $(TOOLS)/$(LDC_HOST)/.done tub/ldc2.conf
	mv $(TOOLS)/$(LDC_HOST)/etc/ldc2.conf $(TOOLS)/$(LDC_HOST)/etc/ldc2.conf.orig || true
	cp tub/ldc2.conf $(TOOLS)/$(LDC_HOST)/etc/ldc2.conf

$(LDC_HOST): $(TOOLS)/$(LDC_HOST)/.done
$(LDC_HOST): $(TOOLS)/$(LDC_HOST)/etc/ldc2.conf
.PHONY: $(LDC_HOST)

$(TOOLS)/$(LDC_HOST)/.done: $(TOOLS)/.way
	cd $(TOOLS)
	wget ${LDC_URL_TAR} -O ${LDC_HOST_TAR}
	tar xf $(LDC_HOST_TAR)
	touch $@

clean-tools:
	$(RM) -vr $(TOOLS)

.PHONY: clean-tools

env-install-wasi:
	$(PRECMD)
	$(call log.header, $@ :: env)
	$(call log.kvp, LDC_VERSION, $(LDC_VERSION)) 
	$(call log.kvp, LDC_URL_TAR, $(LDC_URL_TAR))
	$(call log.kvp, LDC_WASI_BIN, $(LDC_WASI_BIN))
	$(call log.kvp, LDC_WASI, $(LDC_WASI))
	$(call log.close)

.PHONY: env-install-wasi

env: env-install-wasi

help-install-wasi:
	$(PRECMD)
	$(call log.header, $@ :: help)
	$(call log.help, "make help-install-wasi", "Will show this help text")
	$(call log.help, "make install-wasi-wasm-toolchain", "Install the LDC2 compiler and wasi library")
	$(call log.help, "make clean-tools", "Remove the tool chain")
	$(call log.close)

.PHONY: help-install-wasi

help: help-install-wasi

proper: clean-tools
endif
