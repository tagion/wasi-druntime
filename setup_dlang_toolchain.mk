# tools director
TOOLS:=$(abspath $(REPOROOT)/tools)
LDC_VERSION?=1.37.0
DLANG:=$(TOOLS)/dlang
DLANG_INSTALL:=$(DLANG)/install.sh 
DLANG_INSTALL_URL:=https://dlang.org/install.sh
LDC_NAME:=ldc-$(LDC_VERSION)
DLANG_PATH=$(HOME)/dlang/$(LDC_NAME)
LDC_BIN:=$(DLANG_PATH)/bin
LDC_WASI:=$(LDC_BIN)/ldc2
LDC_SOURCE:=$(DLANG_PATH)/activate
DC:=$(LDC_BIN)/ldc2
LDC_CONF?=$(DLANG_PATH)/etc/ldc2.conf

$(DLANG_INSTALL):
	$(PRECMD)
	mkdir -p $(DLANG)
	wget $(DLANG_INSTALL_URL) -O $@
	chmod 750 $@


$(DLANG_PATH): $(DLANG_INSTALL)
	$(PRECMD)
	$(DLANG_INSTALL) install $(LDC_NAME)

install-dlang: $(DLANG_PATH)

.PHONY: install-dlang

env-dlang:
	@echo "DLANG_PATH=$(DLANG_PATH)"
	@echo "DLANG_INSTALL=$(DLANG_INSTALL)"
	@echo "LDC_BIN=$(LDC_BIN)"
	@echo "LDC_SOURCE=$(LDC_SOURCE)"
	@echo "DC=$(DC)"
	@echo "LDC_CONF=$(LDC_CONF)"
