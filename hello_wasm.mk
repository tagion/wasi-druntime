
WASMLD?=$(WASI_BIN)/wasm-ld
DC?=ldc2

MAIN:=hello_wasm.wasm
DFILES+=hello_wasm.d
OBJS:=${DFILES:.d=.o}

DFLAGS+=-defaultlib=c,druntime-ldc,phobos2-ldc
DFLAGS+=-I$(LDC_RUNTIME_ROOT)/druntime/src
DFLAGS+=-I$(LDC_RUNTIME_ROOT)/phobos
#DFLAGS+=-d-version=Posix
DFLAGS+=-mtriple=wasm32-unknown-wasi
DFLAGS+=-c

#LIBS+=$(addprefix $(OBJ_DIR),$($(call dfiles,$(DRUNTIME_SRC)):.d=.o))
#LIBS+=$(addprefix $(OBJ_DIR),$($(call dfiles,$(PHOBOS_SRC)):.d=.o))
LIBS+=$(LIB_DIR)/libdruntime-ldc.a
LIBS+=$(LIB_DIR)/libphobos2-ldc.a
LIB_WASI+=$(WASI_SDK_PREFIX)/share/wasi-sysroot/lib/wasm32-wasi/libc.a
#LIB_WASI+=$(WASI_SDK_PREFIX)/share/wasi-sysroot/lib/wasm32-wasi/librt.a
#LIB_WASI+=$(WASI_SDK_PREFIX)/share/wasi-sysroot/lib/wasm32-wasi/libdl.a
#LIB_WASI+=$(WASI_SDK_PREFIX)/share/wasi-sysroot/lib/wasm32-wasi/libpthread.a

LDFLAGS+=--export=__data_end
LDFLAGS+=--export=__heap_base
LDFLAGS+=--allow-undefined
#LDFLAGS+=--no-entry
#LDFLAGS+=--verbose 
#LDFLAGS+=-Wl,--fatal-warnings


run: $(LIBS) 

run: wasm-run

wasm-env:
	@echo DFILES=$(DFILES)
	@echo OBJS=$(OBJS)
	@echo LIBS=$(LIBS)
	@echo DFLAGS=$(DFLAGS)
	@echo LDFLAGS=$(LDFLAGS)

wasm-run: $(MAIN)
	wasmer $<

$(MAIN): $(OBJS) $(LIBS) 
	$(WASMLD) $< $(LDFLAGS) $(LIBS) $(LIB_WASI)  -o $@

$(OBJS): $(DFILES)
	$(DC) $< $(DFLAGS)

CLEAN+=clean-test

clean-test:
	rm -f $(OBJS)
	rm -f $(MAIN)

clean: clean-test
