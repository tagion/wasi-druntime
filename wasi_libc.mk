.SUFFIXES:
.ONESHELL:
.SECONDARY:

WASI_LIBC:=$(REPOROOT)/wasi-libc
WASI_LIBC_BUILD:=$(WASI_LIBC)/build

build-wasi-libc: $(WASI_LIBC_BUILD)
	@$(MAKE) -j -C $(WASI_LIBC_BUILD)


$(WASI_LIBC_BUILD):
	cd $(WASI_LIBC) 
	cmake cmake -S . -B build -DCMAKE_C_COMPILER=$(CC)

env-wasi-libc:
	@ench "----- $@ :: env"
	@echo "CD              = $(CC)"
	@echo "WASI_LIBC       = $(WASI_LIBC)"
	@echo "WASI_LIBC_BUILD = $(WASI_LIBC_BUILD)"
	@echo

.PHONY: env-wasi-lib

env: env-wasi-lib

proper-wasi-libc:
	@rm -fR $(WASI_LIBC_BUILD)

.PHONY: proper-wasi-libc

prober: proper-wasi-libc

