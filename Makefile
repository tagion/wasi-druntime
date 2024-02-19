include git.mk
include setup.mk

HELP+=help-main

#WASI_BUILD:=$(REPOROOT)/ldc-build-runtime.tmp

.PHONY: help info



all:

include wasi_libc.mk

include wasi_sdk.mk

include ldc_runtime.mk

include hello_wasm.mk

#include llvm.mk 

help:
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


info: 
	@echo $@

all: prebuild run

.PHONY: run

run:
	@echo "Done"

subdate:
	git submodule update --init --recursive

spull:
	git pull --recurse-submodules

clean: 
	@echo $@ 

proper: clean
	@echo $@
	rm -fR build

