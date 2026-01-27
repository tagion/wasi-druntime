CMAKE_VERSION:=4.0
CMAKE_BUILD_REVISION:=3
CMAKE_ARCH:=linux-x86_64
CMAKE_INSTALLATION:=cmake-$(CMAKE_VERSION).$(CMAKE_BUILD_REVISION)-$(CMAKE_ARCH)
CMAKE_FILE_TGZ:=$(CMAKE_INSTALLATION).tar.gz
CMAKE_TMP:=/tmp
CMAKE_URL:=https://cmake.org/files/v$(CMAKE_VERSION)/$(CMAKE_FILE_TGZ)
CMAKE_ROOT:=$(CMAKE_TMP)/$(CMAKE_INSTALLATION)
CMAKE:=$(CMAKE_ROOT)/bin/cmake

export PATH:=$(CMAKE_ROOT)/bin/:$(PATH)
## don't modify from here
#mkdir ~/temp

install-cmake: $(CMAKE_ROOT)


$(CMAKE_ROOT): $(CMAKE_TMP)/$(CMAKE_FILE_TGZ)
	cd $(CMAKE_TMP) 
	tar -xzvf $<

$(CMAKE_TMP)/$(CMAKE_FILE_TGZ):
	cd $(CMAKE_TMP)
	wget $(CMAKE_URL)

env-cmake:
	@echo "----- $@ :: env"
	@echo "CMAKE_VERSION          = $(CMAKE_VERSION)" 
	@echo "CMAKE_BUILD_REVISION   = $(CMAKE_BUILD_REVISION)" 
	@echo "CMAKE_URL              = $(CMAKE_URL)"
	@echo "CMAKE_INSTALLATION     = $(CMAKE_INSTALLATION)"
	@echo "CMAKE_FILE_TGZ         = $(CMAKE_FILE_TGZ)"
	@echo "CMAKE_ROOT             = $(CMAKE_ROOT)"
	@echo "CMAKE                  = $(CMAKE)"
	@echo "PATH                   = $(PATH)"
	@echo 

.PHONY: env-cmake

env: env-cmake
