

LDC_ROOT:=$(REPOROOT)/ldc
LDC_BUILD:=$(LDC_ROOT)/build

help-ldc-runtime:
	@echo "Usage $@"
	@echo
	@echo make env-ldc-runtime - Print setting for the ldc-build-runtime
	@echo
	@echo make clean-ldc-runtime - Remove the build
	@echo 

.PHONY: help-ldc-runtime

help: help-ldc-runtime


env-ldc-runtime:
	@echo "----- $@ :: env"
	@echo "LDC_RUNTIME_ROOT=$(LDC_RUNTIME_ROOT)"
	@echo "LDC_RUNTIME     =$(LDC_RUNTIME)"
	@echo

.PHONY: env-ldc-runtime




#prebuild: $(RUNTIME_BUILD)/.done

#$(RUNTIME_BUILD)/.done:
#	ldc-build-runtime $(LDC_RUNTIME)
#	touch $@


build-ldc: $(LDC_BUILD)/.done

$(LDC_BUILD)/.done:
	@cd $(LDC_ROOT)
	source $(LDC_SOURCE)
	which ldc2
	which wasm-ld
	cmake -S. -Bbuild && cmake --build build
	#touch $@

test77:
	echo $@

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


