.SUFFIXES:
.ONESHELL:
.SECONDARY:

include git.mk
include setup.mk

HELP+=help-main

#WASI_BUILD:=$(REPOROOT)/ldc-build-runtime.tmp

.PHONY: help info

LDC_BIN_BUILD:=$(REPOROOT)/ldc/build/bin/ldc2

ifneq ("$(wildcard $(LDC_BIN_BUILD))","")
DC:=$(LDC_BIN_BUILD)
endif

run:

native:
	$(MAKE) all NATIVE=1

include setup_dlang_toolchain.mk

#include llvm.mk 

include wasi_libc.mk

include wasi_sdk.mk
#ifdef NATIVE 
include ldc_runtime.mk
#else
include wasi_druntime.mk 
#all: libdruntime libphobos
#endif

include cmake_install.mk

include hello_wasm.mk

help:
	@echo "----- $@" 
	@echo
	@echo "make subdate   : If the repo been clone with out --recursive then run the"
	@echo
	@echo "make spull     : All the submodules can be pull by"
	@echo
	@echo "make all       : Build all"
	@echo
	@echo "make native    : Build native"
	@echo
	@echo "make help      : Prints this help text"
	@echo
	@echo "make info      : Prints the Link and Compile setting"
	@echo
	@echo "make proper    : Clean all"
	@echo
	@echo "make clean     : Clean the build"
	@echo


%/.done:
	touch $@

info: 
	@echo $@

prebuild: subdate
prebuild: install-dlang

all: prebuild

subdate: $(REPOROOT)/.done
	#git submodule update --init --recursive 

spull:
	git pull --recurse-submodules

clean: 
	@echo $@ 

clean-build:
	rm -fR build

proper: clean clean-build

install-wasi-sdk: install-cmake

install-dlang: install-wasi-sdk

build-wasi-libc: install-dlang

build-ldc: build-wasi-libc

install: build-ldc
	cd /tmp
	ls -tral| tail -10
