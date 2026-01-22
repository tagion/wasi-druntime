# tools director
TOOLS:=$(abspath $(REPOROOT)/tools)
LDC_VERSION?=1.41.0
DLANG:=$(TOOLS)/dlang
DLANG_INSTALL:=$(DLANG)/install.sh 
DLANG_INSTALL_URL:=https://dlang.org/install.sh
LDC_NAME:=ldc-$(LDC_VERSION)
DLANG_PATH=$(HOME)/dlang/$(LDC_NAME)
LDC_SOURCE=$(DLANG_PATH)/activate
LDC_BIN?=$(DLANG_PATH)/bin
LDC:=$(LDC_BIN)/ldc2

ifeq ("$(wildcard $(LDC))","")
$(warning ---------------- )
$(warning The ldc D compiler has not been installed)
$(warning To install this execute)
$(warning make install-dlang)
$(warning or set LDC_BIN to the location of the ldc compiler)
endif

$(DLANG_INSTALL):
	$(PRECMD)
	mkdir -p $(DLANG)
	wget $(DLANG_INSTALL_URL) -O $@
	chmod 750 $@


$(DLANG_PATH): $(DLANG_INSTALL)
	$(PRECMD)
	$(DLANG_INSTALL) install $(LDC_NAME)

install-dlang: $(DLANG_PATH)


env-dlang:
	@echo "----- $@ :: env"
	@echo "LDC_VERSION       = $(LDC_VERSION)" 
	@echo "LDC_NAME          = $(LDC_NAME)"
	@echo "LDC               = $(LDC)"
	@echo "LDC_BIN           = $(LDC_BIN)"
	@echo "DLANG             = $(DLANG)"
	@echo "DLANG_INSTALL     = $(DLANG_INSTALL)"
	@echo "DLANG_INSTALL_URL = $(DLANG_INSTALL_URL)"
	@echo "DLANG_PATH        = $(DLANG_PATH)"
	@echo 

.PHONY: env-dlang

env: env-install-dlang

help-dlang:
	@echo "----- $@ : help"
	@echo
	@echo "make install-dlang Install the D compiler"
	@echo
	@echo "make env-dlang List the environment" 
	@echo

.PHONY: help-dlang

help: help-dlang


