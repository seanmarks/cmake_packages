#!/bin/bash -eE

export CC=gcc
export CXX=g++

############################################


### Configure ###

# Create/reset build directory
build_dir="$PWD/build"
[[ -d $build_dir ]] && rm -r $build_dir
mkdir -p $build_dir

# Configure from build directory
cd $build_dir
cmake .. \
	-DCMAKE_INSTALL_PREFIX="${HOME}/programs/Foo"

### Build ###

make && make install
