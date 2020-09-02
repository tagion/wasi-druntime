
#
# Make file for wasi-sdk
#

WASI_SDK_VERSION?=8.0
WASI_SDK:=wasi-sdk-$(WASI_SDK_VERSION)
WASI_SDK_FOLDER:=wasi-sdk-8
WASI_SDK_TGZ:=wasi-sdk-$(WASI_SDK_VERSION)-linux.tar.gz
WASI_SDK_URL:=https://github.com/CraneStation/wasi-sdk/releases/download/$(WASI_SDK_FOLDER)/$(WASI_SDK_TGZ)

WASI_SDK_POSIX_PATCH=sed -i 's|set(CMAKE_SYSTEM_NAME Wasm)|set(CMAKE_SYSTEM_NAME Linux)|' $(WASI_SDK_PREFIX)/share/cmake/wasi-sdk.cmake
export WASI_SDK_PREFIX=$(REPOROOT)/$(WASI_SDK)

HELP+=help-wasi-sdk
help-wasi-sdk:

ALL+=$(WASI_SDK_PREFIX)/.touch

lINFO+=info-wask-sdk

info-wask-sdk:
	@echo "Setup parameters for wasi-sdk"
	@echo "WASI_SDK       =$(WASI_SDK)"
	@echo "WASI_SDK_PREFIX=$(WASI_SDK_FOLDER)"
	@echo "WASI_SDK_TGZ   =$(WASI_SDK_TGZ)"
	@echo "WASI_SDK_URL   =$(WASI_SDK_URL)"
	@echo


$(WASI_SDK_PREFIX)/.touch:$(WASI_SDK_PREFIX)
	$(WASI_SDK_POSIX_PATCH)
	touch $@

$(WASI_SDK_PREFIX): $(WASI_SDK_TGZ)
	tar -xzvf $<

$(WASI_SDK_TGZ):
	wget $(WASI_SDK_URL)

clean-wasm-sdk:
	rm -fR $(WASI_SDK_FOLDER)


CLEAN+=clean-wasm-sdk

proper-wask-sdk:
	rm -f $(WASI_SDK_TGZ)

PROPER+=proper-wask-sdk
