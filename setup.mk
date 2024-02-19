
TOOLS:=$(REPOROOT)/tools

LDC_BUILD_RUNTIME?=$(shell which ldc-build-runtime)
WASI_SDK_VERSION:=21

ifeq ($(LDC_BUILD_RUNTIME),)
$(error missing ldc-build-runtime)
endif

