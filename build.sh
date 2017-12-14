#!/bin/bash

export INCLUDE=$INCLUDE"D:\system\usr\src\x264;D:\system\usr\src\aac.build;"
export LIB=$LIB"D:\system\usr\src\x264;D:\system\usr\src\aac.build\Release;"
export PKG_CONFIG_PATH=$PKG_CONFIG_PATH:/d/system/usr/src/x265/build/vc15-x86/x265/lib/pkgconfig:/d/system/usr/src/openssl

if test x"$1" != x"--continue"; then
./configure --toolchain=msvc --enable-gpl --enable-version3 --enable-nonfree --extra-cflags=-DAACDECODER_LIB_VL0 \
--enable-avisynth --enable-openssl \
--enable-libx264 --enable-libx265 --enable-libfdk-aac
fi

if test x"$1" != x"--config"; then
make -j
fi
