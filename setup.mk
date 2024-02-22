
TOOLS:=$(REPOROOT)/tools

WASI_SDK_VERSION?=21

ifdef NATIVE
	RUNTIME_BUILD:=$(REPOROOT)/ldc-build-runtime.tmp
	USE_LDC_BUILD_RUNTIME?=1
else
	RUNTIME_BUILD:=$(REPOROOT)/ldc-build-runtime.wasi
	WASI_BUILD:=$(RUNTIME_BUILD)
	LDC_RUNTIME_ROOT:=ldc/runtime
endif

ifdef USE_LDC_BUILD_RUNTIME
LDC_BUILD_RUNTIME?=$(shell which ldc-build-runtime)
ifeq ($(LDC_BUILD_RUNTIME),)
$(error missing ldc-build-runtime)
endif
endif

