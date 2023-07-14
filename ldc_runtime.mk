
LDC_RUNTIME_ROOT:=$(REPOROOT)/ldc/runtime
LDC_RUNTIME+=
#LDC_RUNTIME+=--ninja
LDC_RUNTIME+=--dFlags=-mtriple=wasm32-wasi
LDC_RUNTIME+=--buildDir=$(WASI_BUILD)
LDC_RUNTIME+=--ldcSrcDir=../
#LDC_RUNTIME+=--linkerFlags=-L$(WASI_SDK_PREFIX)/wasi-libc/sysroot/lib/wasm32-wasi
LDC_RUNTIME+=CMAKE_TOOLCHAIN_FILE=$(WASI_SDK_PREFIX)/share/cmake/wasi-sdk.cmake
LDC_RUNTIME+=WASI_SDK_PREFIX=$(WASI_SDK_PREFIX) BUILD_SHARED_LIBS=OFF

help-ldc-runtime:
	@echo "Usage $@"
	@echo
	@echo make info-ldc-runtime - Print setting for the ldc-build-runtime
	@echo
	@echo make clean-ldc-runtime - Remove the build
	@echo 

.PHONY: help-ldc-runtime

help: help-ldc-runtime


info-ldc-runtime:
	@echo "Setup parameters for ldc-build-runtime"
	@echo LDC_RUNTIME_ROOT=$(LDC_RUNTIME_ROOT)
	@echo LDC_RUNTIME     =$(LDC_RUNTIME)
	@echo

ALL+=$(WASI_BUILD)/.done $(WASI_BUILD)/ldc2.conf

.PHONY: ldc-build-runtime

info: info-ldc-runtime

prebuild: $(WASI_BUILD)/.done

$(WASI_BUILD)/.done:
	cd $(LDC_RUNTIME_ROOT); ldc-build-runtime $(LDC_RUNTIME)
	touch $@


define LDC_CONF
"^wasm(32|64)-":
  {
      switches = [
          "-defaultlib=c,druntime-ldc,phobos2-ldc",
          "-link-internally",
      ];
      post-switches = [
       "-I$(LDC_RUNTIME_ROOT)/druntime/src>",
       "-I$(LDC_RUNTIME_ROOT)/phobos>",
      ],
      lib-dirs = ["$(WASI_BUILD)/lib",
                  "$(WASI_SDK_PREFIX)/share/wasi-sysroot/lib/wasm32-wasi/"];
  };
endef

export LDC_CONF_TEXT=$(LDC_CONF)

ldc2-conf: $(WASI_BUILD)/ldc2.conf
	@echo $<


$(WASI_BUILD)/ldc2.conf:
	@echo "$${LDC_CONF_TEXT}" > $@


CLEAN+=clean-ldc-runtime

clean-ldc-runtime:
	@echo "clean $@"
	rm -fR $(WASI_BUILD)

.PHONY: clean-ldc-runtime

clean: clean-ldc-runtime


