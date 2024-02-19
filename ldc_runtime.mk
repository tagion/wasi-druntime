
LDC_RUNTIME_ROOT:=$(REPOROOT)/ldc/runtime
#LDC_RUNTIME+=
#LDC_RUNTIME+=--ninja
ifdef NATIVE
LDC_RUNTIME+=--buildDir=$(RUNTIME_BUILD)
else 
LDC_RUNTIME+=--dFlags=-mtriple=wasm32-wasi
LDC_RUNTIME+=--buildDir=$(RUNTIME_BUILD)
LDC_RUNTIME+=CMAKE_TOOLCHAIN_FILE=$(WASI_SDK_PREFIX)/share/cmake/wasi-sdk.cmake
endif
LDC_RUNTIME+=--ldcSrcDir=../
#LDC_RUNTIME+=--linkerFlags=-L$(WASI_SDK_PREFIX)/wasi-libc/sysroot/lib/wasm32-wasi
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

ldc-runtime: $(RUNTIME_BUILD)/.done $(RUNTIME_BUILD)/ldc2.conf

.PHONY: ldc-runtime

prebuild: ldc-runtime

info: info-ldc-runtime

prebuild: $(RUNTIME_BUILD)/.done

$(RUNTIME_BUILD)/.done:
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
      lib-dirs = ["$(RUNTIME_BUILD)/lib",
                  "$(WASI_SDK_PREFIX)/share/wasi-sysroot/lib/wasm32-wasi/"];
  };
endef

export LDC_CONF_TEXT=$(LDC_CONF)

ldc2-conf: $(RUNTIME_BUILD)/ldc2.conf
	@echo $<


$(RUNTIME_BUILD)/ldc2.conf:
	@echo "$${LDC_CONF_TEXT}" > $@


CLEAN+=clean-ldc-runtime

clean-ldc-runtime:
	@echo "clean $@"
	rm -fR $(RUNTIME_BUILD)

.PHONY: clean-ldc-runtime

clean: clean-ldc-runtime


