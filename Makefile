include git.mk
include setup.mk

HELP+=help-main
#INFO+=info-main

# WASI_SDK_FOLDER:=wasi-sdk-8.0
# WASI_SDK_TGZ:=wasi-sdk-8.0-linux.tar.gz
# WASI_SDK:=https://github.com/CraneStation/wasi-sdk/releases/download/$(WASI_SDK)/$(WASI_SDK_TGZ)

WASI_BUILD:=$(REPOROOT)/ldc-build-runtime.tmp
# export WASI_SDK_PREFIX=$(REPOROOT)/wasi-sdk-8.0

.PHONY: help info

help: $(HELP)

include wasi_libc.mk

include wasi_sdk.mk

help-main:
	@echo "Usage "
	@echo
	@echo "make all       : Build all"
	@echo
	@echo "make info      : Prints the Link and Compile setting"
	@echo
	@echo "make proper    : Clean all"
	@echo
	@echo "make clean     : Clean the build"
	@echo
#	@echo "make PRECMD=   : Verbose mode"
#	@echo "                 make PRECMD= <tag> # Prints the command while executing"
	@echo

info: $(INFO)

all: $(ALL)
#llvm-build: $(LLVM_BUILD)/.touch

# $(WASI_SDK_TGZ):
# 	wget $(WASI_SDK)
#	curl $(WASI_SDK) --output $@

ldc/.touch:
	cd ldc/runtime; \
	ldc-build-runtime --ninja --dFlags=-mtriple=wasm32-wasi \
	--buildDir=$(WASI_BUILD) \
	--ldcSrcDir=../ \
        --linkerFlags=-L$(WASI_SDK_PREFIX)/wasi-libc/sysroot/lib/wasm32-wasi \
	CMAKE_TOOLCHAIN_FILE=$(WASI_SDK_PREFIX)/share/cmake/wasi-sdk.cmake \
        WASI_SDK_PREFIX=$(WASI_SDK_PREFIX) BUILD_SHARED_LIBS=OFF
	touch $@

#--linkerFlags=-L$(WASI_SDK_PREFIX) \
#	C_SYSTEM_LIBS=$(WASI_SDK_PREFIX)/share/wasi-sysroot/lib/wasm32-wasi/
# 	--cFlags=-I$(REPOROOT)/wasi-libc/sysroot/include \

# ldc-subdate: ldc
# #	cd $<;  git submodule update --init --recursive

# ldc:
# 	git clone https://github.com/ldc-developers/ldc.git


subdate:
	git submodule update --init --recursive


clean: $(CLEAN)
#	rm -fR $(WASI_BUILD)


proper: $(CLEAN) $(PROPER)
#	rm -fR $(WASI_SDK_FOLDER)
