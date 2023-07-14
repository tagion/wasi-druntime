
WASMLD?=/opt/wasi-sdk/bin/wasm-ld
DC?=ldc2

MAIN:=hello_wasm.wasm
DFILES+=hello_wasm.d
OBJS:=${DFILES:.d=.o}

DCFLAGS+=-defaultlib=c,druntime-ldc,phobos2-ldc
DCFLAGS+=-I$(LDC_RUNTIME_ROOT)/druntime/src
DCFLAGS+=-I$(LDC_RUNTIME_ROOT)/phobos

DCFLAGS+=-mtriple=wasm32-unknown-unknown-wasm
DCFLAGS+=-c

LDFLAGS+=$(WASI_BUILD)/lib/libdruntime-ldc.a
LDFLAGS+=$(WASI_BUILD)/lib/libphobos2-ldc.a
LDFLAGS+=$(WASI_SDK_PREFIX)/share/wasi-sysroot/lib/wasm32-wasi/libc.a

LDFLAGS+=--export=__data_end
LDFLAGS+=--export=__heap_base
LDFLAGS+=--allow-undefined

run: wasm-run

xxx:
	echo $(DFILES)
	echo $(OBJS)
	echo $(DCFLAGS)

wasm-run: $(MAIN)
	wasmer $<

$(MAIN): $(OBJS)
	$(WASMLD) $< $(LDFLAGS) -o $@

$(OBJS): $(DFILES)
	$(DC) $< $(DCFLAGS)

CLEAN+=clean-test

clean-test:
	rm -f $(OBJS)
	rm -f $(MAIN)
