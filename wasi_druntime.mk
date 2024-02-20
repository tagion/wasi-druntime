
 #/home/carsten/work/legacy-wasm-druntime/ldc/runtime/druntime/src && 
DRUNTIME_SRC:=/home/carsten/work/legacy-wasm-druntime/ldc/runtime/druntime/src 
PHOBOS_SRC:=/home/carsten/work/legacy-wasm-druntime/ldc/runtime/phobos
DC:=/home/carsten/bin/ldc2-1.36.0-linux-x86_64/bin/ldc2
#DFLAGS+=-mtriple=wasm32-linux-wasi
DFLAGS+=-c 
DFLAFS+=--output-o 
DFLAGS+=-conf= 
DFLAGS+=-w -de 
DFLAGS+=-preview=dip1000 -preview=dtorfields -preview=fieldwise 
DFLAGS+=-od=/home/carsten/work/legacy-wasm-druntime/ldc-build-runtime.wasi/objects 
DFLAGS+=-op 
DFLAGS+=-mtriple=wasm32-linux-wasi -O3 -release -femit-local-var-lifetime 

WASI_FILTER:=-a -not -path "*/linux/*" -a -not -path "*/windows/*" -a -not -path "*/tools/*" -a -not -path "*/test/*" -a -not -name "unittest.d" 

dfiles=$(shell find $1 -name "*.d" $(WASI_FILTER) -printf "%P ")
druntime: DINC+=-I$(DRUNTIME_SRC)
phobos: DINC+=-I$(DRUNTIME_SRC)
phobos: DINC+=-I$(PHOBOS_SRC)



#/home/carsten/bin/ldc2-1.36.0-linux-x86_64/bin/ldc2 -c --output-o -conf= -w -de -preview=dip1000 -preview=dtorfields -preview=fieldwise -mtriple=wasm32-linux-wasi -O3 -release -femit-local-var-lifetime -I/home/carsten/work/legacy-wasm-druntime/ldc/runtime/druntime/src -od=/home/carsten/work/legacy-wasm-druntime/ldc-build-runtime.wasi/objects -op 

#DFILES=$(shell find $(DRUNTIME_SRC) -name "*.d" -a -not -path "*/linux/*" -a -not -path "*/windows/*" -printf "%P ")
#DFILES=$(shell find $(DRUNTIME_SRC) -name "*.d" -a -not -path "*/linux/*" -a -not -path "*/windows/*" -printf "%P ")

druntime: DFILES=$(call dfiles,$(DRUNTIME_SRC))
druntime: SRC_DIR=$(DRUNTIME_SRC)
druntime: compile

phobos: DFILES=$(call dfiles,$(PHOBOS_SRC))
phobos: SRC_DIR=$(PHOBOS_SRC)
phobos: compile

test: DFILES=$(call dfiles,$(DRUNTIME_SRC))

test: 
	@echo $(DFILES)

all: druntime


compile:
	cd $(SRC_DIR); $(DC) $(DFLAGS) $(DINC) $(DFILES)

druntime-x:
	cd $(DRUNTIME_SRC); $(DC) $(DFLAGS) $(DINC) $(DFILES)

	
