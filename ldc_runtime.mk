

export LDC_ROOT:=$(REPOROOT)/ldc
export LDC_BUILD:=$(LDC_ROOT)/build

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
	@echo "LDC_RUNTIME      = $(LDC_RUNTIME)"
	@echo "LDC_ROOT         = $(LDC_ROOT)"
	@echo "LDC_BUILD        = $(LDC_BUILD)"
	@echo "LDC_SOURCE       = $(LDC_SOURCE)"
	@echo

.PHONY: env-ldc-runtime


build-ldc: ./build_ldc.sh 
	@echo "Run $< to compile the ldc compiler"

./build_ldc.sh:
	@cat << EOF > $@
	#!/bin/bash
	export LDC_SOURCE=$(LDC_SOURCE)
	export LDC_BUILD=$(LDC_BUILD)
	export LDC_ROOT=$(LDC_ROOT)
	export DLANG_PATH=$(DLANG_PATH)
	. $(LDC_SOURCE)
	cd $(LDC_ROOT)
	cmake -S. -Bbuild && cmake --build build
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


