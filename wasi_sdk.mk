
#
# Make file for wasi-sdk
#

#WASI_SDK_VERSION?=8.0
#WASI_SDK_VERSION?=20
WASI_SDK_VERSION?=21
WASI_SDK:=wasi-sdk-$(WASI_SDK_VERSION).0
WASI_SDK_FOLDER:=wasi-sdk-$(WASI_SDK_VERSION)
WASI_SDK_TGZ:=wasi-sdk-$(WASI_SDK_VERSION).0-linux.tar.gz
#WASI_SDK_URL:=https://github.com/CraneStation/wasi-sdk/releases/download/$(WASI_SDK_FOLDER)/$(WASI_SDK_TGZ)

WASI_SDK_URL:=https://github.com/WebAssembly/wasi-sdk/releases/download/wasi-sdk-$(WASI_SDK_VERSION)/$(WASI_SDK_TGZ)
#https://github.com/WebAssembly/wasi-sdk/releases/download/wasi-sdk-20/wasi-sdk-20.0-linux.tar.gz
#WASI_SDK_POSIX_PATCH=sed -i 's|set(CMAKE_SYSTEM_NAME Wasm)|set(CMAKE_SYSTEM_NAME Linux)|' $(WASI_SDK_PREFIX)/share/cmake/wasi-sdk.cmake

export WASI_SDK_PREFIX=$(REPOROOT)/$(WASI_SDK)
export WASI_BIN=$(WASI_SDK_PREFIX)/bin

help-wasi-sdk:
	@echo $@

.PHONY: help-wasi-sdk

help: help-wasi-sdk


wasi-sdk: $(WASI_SDK_PREFIX)/.done

.PHONY: wasi-sdk

prebuild: wasi-sdk

info-wasi-sdk:
	@echo "Setup parameters for wasi-sdk"
	@echo "WASI_BIN       =$(WASI_BIN)"
	@echo "WASI_SDK       =$(WASI_SDK)"
	@echo "WASI_SDK_PREFIX=$(WASI_SDK_FOLDER)"
	@echo "WASI_SDK_TGZ   =$(WASI_SDK_TGZ)"
	@echo "WASI_SDK_URL   =$(WASI_SDK_URL)"
	@echo

.PHONY: info-wasi-sdk

info: info-wasi-sdk


$(WASI_SDK_PREFIX)/.done:$(WASI_SDK_PREFIX)
	$(WASI_SDK_POSIX_PATCH)
	touch $@

$(WASI_SDK_PREFIX): $(WASI_SDK_TGZ)
	tar -xzvf $<

$(WASI_SDK_TGZ):
	wget $(WASI_SDK_URL)

clean-wasi-sdk:
	rm -fR $(WASI_SDK_FOLDER)

.PHONY: clean-wasm-sdk

clean: clean-wasm-sdk

proper-wasi-sdk:
	@echo $@
	rm -f $(WASI_SDK_TGZ)

.PHONY: proper-wasi-sdk

proper: proper-wasi-sdk

