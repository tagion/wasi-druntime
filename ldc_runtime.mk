

export LDC_ROOT:=$(REPOROOT)/ldc
export LDC_BUILD:=$(LDC_ROOT)/build

CMAKE_PARALLEL?=4
help-ldc-runtime:
	@echo "----- $@ : help"
	@echo
	@echo make env-ldc-runtime - Print setting for the ldc-build-runtime
	@echo
	@echo make clean-ldc-runtime - Remove the build
	@echo 

.PHONY: help-ldc-runtime

help: help-ldc-runtime


env-ldc-runtime:
	@echo "----- $@ :: env"
	@echo "LDC_RUNTIME_ROOT = $(LDC_RUNTIME_ROOT)"
	@echo "LDC_ROOT         = $(LDC_ROOT)"
	@echo "LDC_BUILD        = $(LDC_BUILD)"
	@echo "LDC_SOURCE       = $(LDC_SOURCE)"
	@echo

.PHONY: env-ldc-runtime

env: env-ldc-runtime

build-ldc: ./build_ldc.sh 

./build_ldc.sh:
	@cat << EOF > $@
	#!/bin/bash
	export LDC_SOURCE=$(LDC_SOURCE)
	export LDC_BUILD=$(LDC_BUILD)
	export LDC_ROOT=$(LDC_ROOT)
	export DLANG_PATH=$(DLANG_PATH)
	unset WASI_BIN
	unset WASI_SDK_ROOT
	echo "LDC_SOURCE = $(LDC_SOURCE)"
	env | sort > build_env.log
	. $(LDC_SOURCE)
	cd $(LDC_ROOT)
	pwd
	ldd $(LDC)
	cmake -S. -Bbuild && cmake --build build -j $(CMAKE_PARALLEL)
	EOF
	chmod 750 $@

#export LDC_CONF_TEXT=$(LDC_CONF)

#ldc2-conf: $(RUNTIME_BUILD)/ldc2.conf
#	@echo $<


#$(RUNTIME_BUILD)/ldc2.conf:
#	@echo "$${LDC_CONF_TEXT}" > $@


#CLEAN+=clean-ldc-runtime

clean-ldc-runtime:
	@echo "clean $@"
	rm -fR $(RUNTIME_BUILD)

.PHONY: clean-ldc-runtime

#clean: clean-ldc-runtime


