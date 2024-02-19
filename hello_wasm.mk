
WASMLD?=$(WASI_BIN)/wasm-ld
DC?=ldc2

MAIN:=hello_wasm.wasm
DFILES+=hello_wasm.d
OBJS:=${DFILES:.d=.o}

DFLAGS+=-defaultlib=c,druntime-ldc,phobos2-ldc
DFLAGS+=-I$(LDC_RUNTIME_ROOT)/druntime/src
DFLAGS+=-I$(LDC_RUNTIME_ROOT)/phobos

DFLAGS+=-mtriple=wasm32-unknown-unknown-wasi
DFLAGS+=-c

LDFLAGS+=$(WASI_BUILD)/lib/libdruntime-ldc.a
LDFLAGS+=$(WASI_BUILD)/lib/libphobos2-ldc.a
LDFLAGS+=$(WASI_SDK_PREFIX)/share/wasi-sysroot/lib/wasm32-wasi/libc.a

LDFLAGS+=--export=__data_end
LDFLAGS+=--export=__heap_base
LDFLAGS+=--allow-undefined

run: wasm-run

wasm-env:
	@echo DFILES=$(DFILES)
	@echo OBJS=$(OBJS)
	@echo DFLAGS=$(DFLAGS)
	@echo LDFLAGS=$(LDFLAGS)

wasm-run: $(MAIN)
	wasmer $<

$(MAIN): $(OBJS)
	$(WASMLD) $< $(LDFLAGS) -o $@

$(OBJS): $(DFILES)
	$(DC) $< $(DFLAGS)

CLEAN+=clean-test

clean-test:
	rm -f $(OBJS)
	rm -f $(MAIN)
