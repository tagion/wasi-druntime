include git.mk

WASI_SDK_FOLDER:=wasi-sdk-8
WASI_SDK_TGZ:=wasi-sdk-8.0-linux.tar.gz
WASI_SDK:="https://github.com/CraneStation/wasi-sdk/releases/download/$(WASI_SDK_FOLDER)/$(WASI_SDK_TGZ)"

export WASI_SDK_PREFIX=wasi-sdk-8.0

all: $(WASI_SDK_PREFIX)/.touch ldc/.touch

$(WASI_SDK_PREFIX)/.touch:$(WASI_SDK_PREFIX)
	touch $@

$(WASI_SDK_PREFIX): $(WASI_SDK_TGZ)
	tar -xzvf $<


$(WASI_SDK_TGZ):
	wget $(WASI_SDK)
#	curl $(WASI_SDK) --output $@

ldc/.touch: ldc-subdate
	cd ldc/runtime; \
	ldc-build-runtime --ninja "--dFlags=-mtriple=wasm32-wasi" \
	--ldcSrcDir=../ \
	CMAKE_TOOLCHAIN_FILE="$(WASI_SDK_PREFIX)/share/cmake/wasi-sdk.cmake" \
        WASI_SDK_PREFIX=$(WASI_SDK_PREFIX) BUILD_SHARED_LIBS=OFF
	touch $@

#--linkerFlags=-L$(WASI_SDK_PREFIX) \

ldc-subdate: ldc
#	cd $<;  git submodule update --init --recursive

ldc:
	git clone https://github.com/ldc-developers/ldc.git

subdate:
	git submodule update --init --recursive

clean:
	rm -fR $(WASI_SDK_FOLDER)
