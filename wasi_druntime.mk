.SUFFIXES:
.SECONDARY:
.ONESHELL:
.SECONDEXPANSIOM:

 #/home/carsten/work/legacy-wasm-druntime/ldc/runtime/druntime/src && 

DRUNTIME_SRC:=$(REPOROOT)/ldc/runtime/druntime/src 
PHOBOS_SRC:=$(REPOROOT)/ldc/runtime/phobos
TARGET_DIR:=$(REPOROOT)/ldc-build-runtime.wasi
OBJ_DIR:=$(TARGET_DIR)/objects
LIB_DIR:=$(TARGET_DIR)/lib

LIBPHOBOS2:=$(LIB_DIR)/libphobos2-ldc.a
LIBDRUNTIME:=$(LIB_DIR)/libdruntime-ldc.a
DC!=which ldc2 || /home/carsten/bin/ldc2-1.36.0-linux-x86_64/bin/ldc2
LIB_DFLAGS+=-mtriple=wasm32-unknown-wasi
#LIB_DFLAGS+=-c 
LIB_DFLAGS+=--output-o 
LIB_DFLAGS+=-conf= 
LIB_DFLAGS+=-w -de 
LIB_DFLAGS+=-preview=dip1000 -preview=dtorfields -preview=fieldwise 
#LIB_DFLAGS+=-d-version=Posix
LIB_DFLAGS+=-od=$(TARGET_DIR)/objects 
LIB_DFLAGS+=-op 
LIB_DFLAGS+=-oq

#LIB_DFLAGS+=-mtriple=wasm32-linux-wasi
#-O3 -release -femit-local-var-lifetime 
LIB_DFLAGS+=--lib

WASI_FILTER+=-a -not -path "*/linux/*" -a -not -path "*/windows/*" -a -not -path "*/tools/*" -a -not -path "*/test/*" -a -not -name "unittest.d" 
WASI_FILTER+=-a -not -name "eh_msvc.d"
WASI_FILTER+=-a -not -name "dwarfeh.d"
WASI_FILTER+=-a -not -name "dwarf.d"

dfiles=$(shell find $1 -name "*.d" $(WASI_FILTER) -printf "%P ")

libdruntime: $(LIBDRUNTIME)

#$(LIBDRUNTIME): $(LIB_DIR)/libdruntime-ldc.a
$(LIBDRUNTIME): DINC+=-I$(DRUNTIME_SRC)
$(LIBDRUNTIME): DFILES=$(call dfiles,$(DRUNTIME_SRC))
$(LIBDRUNTIME): SRC_DIR=$(DRUNTIME_SRC)

libphobos2: $(LIBPHOBOS2) 

$(LIBPHOBOS2): DFILES=$(call dfiles,$(PHOBOS_SRC))
$(LIBPHOBOS2): DINC+=-I$(DRUNTIME_SRC)
$(LIBPHOBOS2): DINC+=-I$(PHOBOS_SRC)
$(LIBPHOBOS2): SRC_DIR=$(PHOBOS_SRC)
#phobos2: compile

ways: $(OBJ_DIR)/.way
ways: $(LIB_DIR)/.way

%/.way:
	mkdir -p $(@D)
	touch $@

$(LIB_DIR)/%.a: ways 
	cd $(SRC_DIR); $(DC) $(LIB_DFLAGS) $(DINC) $(DFILES) -of $@

#compile: ways 
#	cd $(SRC_DIR); $(DC) $(LIB_DFLAGS) $(DINC) $(DFILES) -of $(LIB)

check-druntime:
	find $(DRUNTIME_SRC) -name "*.d" $(WASI_FILTER) -exec grep -nH _d_throw_exception {} \;

check-phobos:
	find $(PHOBOS_SRC) -name "*.d" $(WASI_FILTER) -exec grep -nH _d_throw_exception {} \;

dfiles-druntime:
	find $(DRUNTIME_SRC) -name "*.d" $(WASI_FILTER) -printf "%P\n"

clean-druntime:
	rm -f $(LIB_DIR)/libdruntime-ldc.a
	rm -f $(LIB_DIR)/libphobos2-ldc.a

clean: clean-druntime

