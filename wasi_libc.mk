.SUFFIXES:
.ONESHELL:
.SECONDARY:

WASI_LIBC:=$(REPOROOT)/wasi-libc
WASI_LIBC_BUILD:=$(WASI_LIBC)/build

build-wasi-libc: $(WASI_LIBC_BUILD)/.done

$(WASI_LIBC_BUILD)/.done: $(WASI_LIBC_BUILD)
	@$(MAKE) -j -C $(WASI_LIBC_BUILD)
	touch $@

$(WASI_LIBC_BUILD): wasi-sdk
	@cd $(WASI_LIBC) 
	cmake cmake -S . -B build -DCMAKE_C_COMPILER=$(CC)

help-wasi-libc:
	@echo "----- $@ : help"
	@echo
	@echo "make build-wasi-libc : Build wasi-libc"
	@echo
	@echo "make clean-wasi-libc : The wasi-libc build" 
	@echo

.PHONY: help-wasi-libc

help: help-wasi-libc

env-wasi-libc:
	@ench "----- $@ :: env"
	@echo "CD              = $(CC)"
	@echo "WASI_LIBC       = $(WASI_LIBC)"
	@echo "WASI_LIBC_BUILD = $(WASI_LIBC_BUILD)"
	@echo

.PHONY: env-wasi-lib

env: env-wasi-lib

clean-wasi-libc:
	@rm -fR $(WASI_LIBC_BUILD)

.PHONY: clean-wasi-libc

proper: clean-wasi-libc

