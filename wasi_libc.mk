.SUFFIXES:
.ONESHELL:
.SECONDARY:


WASM_AR:=$(WASI_BIN)/llvm-ar
WASM_NM:=$(WASI_BIN)/llvm-nm
WASM_CC:=$(WASI_BIN)/clang

WASI_LIBC:=$(REPOROOT)/wasi-libc
WASI_LIBC_BUILD:=$(WASI_LIBC)/build

build-wasi-libc: $(WASI_LIBC_BUILD)
	@$(MAKE) -j -C $(WASI_LIBC_BUILD)


$(WASI_LIBC_BUILD):
	cd $(WASI_LIBC) 
	cmake cmake -S . -B build -DCMAKE_C_COMPILER=$(CC)

env-wasi-libc:
	@echo "CD = $(CC)"

proper-wasi-libc:
	@rm -fR $(WASI_LIBC_BUILD)

.PHONY: proper-wasi-libc

prober: proper-wasi-libc

