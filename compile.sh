#!/bin/bash -eE

export CC=gcc
export CXX=g++

############################################

XDRFILE_DIR="${HOME}/programs/xdrfile/1.1.4"

### Configure ###

# Create/reset build directory
build_dir="$PWD/build"
[[ -d $build_dir ]] && rm -r $build_dir
mkdir -p $build_dir

# Configure from build directory
cd $build_dir
cmake .. \
	-DCMAKE_INSTALL_PREFIX="${HOME}/programs/Foo" \
	-DCMAKE_PREFIX_PATH="${XDRFILE_DIR}"

### Build ###

make && make install
