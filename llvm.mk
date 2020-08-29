LLVM_TOOLS:=$(TOOLS)/llvm

LLVM_BUILD:=build/llvm

LLVM_FLAGS+=-G Ninja
LLVM_FLAGS+=$(LLVM_SRC)
LLVM_FLAGS+=-DCMAKE_BUILD_TYPE=Release
LLVM_FLAGS+=-DCMAKE_INSTALL_PREFIX=$(LLVM_TOOLS)
LLVM_FLAGS+=-DLLVM_BINUTILS_INCDIR=/usr/include
LLVM_FLAGS+=-DLLVM_TARGETS_TO_BUILD='AArch64;ARM;Mips;MSP430;NVPTX;PowerPC;RISCV;WebAssembly;X86'
LLVM_FLAGS+=-DCOMPILER_RT_INCLUDE_TESTS=OFF
LLVM_FLAGS+=-DLLVM_INCLUDE_TESTS=OFF

LLVM_SRC_TGZ:=llvm-9.0.1.src.tar.xz
LLVM_SRC_URL:=https://github.com/ldc-developers/llvm-project/releases/download/ldc-v9.0.1/$(LLVM_SRC_TGZ)
LLVM_SRC:=$(REPOROOT)/llvm-9.0.1.src

$(LLVM_BUILD)/.touch: $(LLVM_SRC) $(LLVM_TOOLS)
	mkdir -p $(@D)
	cd $(@D); cmake $(LLVM_FLAGS); ninja install
	touch $@

$(LLVM_TOOLS):
	mkdir -p $(LLVM_TOOLS)

$(LLVM_SRC):
	curl -OL $(LLVM_SRC_URL)
	tar -xf $(LLVM_SRC_TGZ)

llvm-clean:
	rm -fR $(LLVM_SRC)
	rm -f $(LLVM_SRC_TGZ)

PROPER+=$(llvm-clean)
