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

include ldc_runtime.mk

help-main:
	@echo "Usage "
	@echo
	@echo "make subdate   : If the repo been clone with out --recursive then run the"
	@echo
	@echo "make spull     : All the submodules can be pull by"
	@echo
	@echo "make all       : Build all"
	@echo
	@echo "make help      : Prints this help text"
	@echo
	@echo "make info      : Prints the Link and Compile setting"
	@echo
	@echo "make proper    : Clean all"
	@echo
	@echo "make clean     : Clean the build"
	@echo

info: $(INFO)

all: $(ALL)

subdate:
	git submodule update --init --recursive

spull:
	git pull --recurse-submodules

clean: $(CLEAN)

proper: $(CLEAN) $(PROPER)
