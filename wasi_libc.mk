

WASM_AR:=$(WASI_BIN)/llvm-ar
WASM_NM:=$(WASI_BIN)/llvm-nm
WASM_CC:=$(WASI_BIN)/clang

build-wasi-libc:
	make -C wasi-libc WASM_CC=$(WASM_CC) WASM_AR=$(WASM_AR) WASM_NM=$(WASM_NM)
