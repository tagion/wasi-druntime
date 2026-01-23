#!/bin/bash
cd "$(dirname "$0")"
pwd
make install
LDC_BUILD=ldc/build
if [ ! -d $LDC_BUILD ]; then
    ./build_ldc.sh
fi
