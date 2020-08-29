
LDC_RUNTIME_ROOT:=$(REPOROOT)/ldc/runtime
LDC_RUNTIME+=
LDC_RUNTIME+=--ninja
LDC_RUNTIME+=--dFlags=-mtriple=wasm32-wasi
LDC_RUNTIME+=--buildDir=$(WASI_BUILD)
LDC_RUNTIME+=--ldcSrcDir=../
LDC_RUNTIME+=--linkerFlags=-L$(WASI_SDK_PREFIX)/wasi-libc/sysroot/lib/wasm32-wasi
LDC_RUNTIME+=CMAKE_TOOLCHAIN_FILE=$(WASI_SDK_PREFIX)/share/cmake/wasi-sdk.cmake
LDC_RUNTIME+=WASI_SDK_PREFIX=$(WASI_SDK_PREFIX) BUILD_SHARED_LIBS=OFF

HELP+=help-ldc-runtime
help-ldc-runtime:

INFO+=info-ldc-runtime

info-ldc-runtime:
	@echo "Setup parameters for ldc-build-runtime"
	@echo LDC_RUNTIME_ROOT=$(LDC_RUNTIME_ROOT)
	@echo LDC_RUNTIME     =$(LDC_RUNTIME)
	@echo

ALL+=$(WASI_BUILD)/.touch


$(WASI_BUILD)/.touch:
	cd $(LDC_RUNTIME_ROOT); ldc-build-runtime $(LDC_RUNTIME)
	touch $@
	# cd ldc/runtime; \
	# ldc-build-runtime --ninja --dFlags=-mtriple=wasm32-wasi \
	# --buildDir=$(WASI_BUILD) \
	# --ldcSrcDir=../ \
        # --linkerFlags=-L$(WASI_SDK_PREFIX)/wasi-libc/sysroot/lib/wasm32-wasi \
	# CMAKE_TOOLCHAIN_FILE=$(WASI_SDK_PREFIX)/share/cmake/wasi-sdk.cmake \
        # WASI_SDK_PREFIX=$(WASI_SDK_PREFIX) BUILD_SHARED_LIBS=OFF
	# touch $@
