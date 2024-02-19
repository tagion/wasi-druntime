
TOOLS:=$(REPOROOT)/tools

LDC_BUILD_RUNTIME?=$(shell which ldc-build-runtime)
WASI_SDK_VERSION:=21

ifdef NATIVE
	RUNTIME_BUILD:=$(REPOROOT)/ldc-build-runtime.tmp
else
	RUNTIME_BUILD:=$(REPOROOT)/ldc-build-runtime.wasi
	WASI_BUILD:=$(RUNTIME_BUILD)
endif
ifeq ($(LDC_BUILD_RUNTIME),)
$(error missing ldc-build-runtime)
endif

