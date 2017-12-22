#!/bin/bash

export INCLUDE=$INCLUDE"D:\system-x86\usr\include;"
export LIB=$LIB"D:\system-x86\usr\lib;"
export PKG_CONFIG_PATH=$PKG_CONFIG_PATH:/d/system-x86/usr/lib/pkgconfig:/d/system-x86/usr/share/pkgconfig

if test x"$1" != x"--continue"; then
./configure --toolchain=msvc --enable-gpl --enable-version3 --enable-nonfree \
--extra-cflags=-DAACDECODER_LIB_VL0 --extra-ldflags=legacy_stdio_definitions.lib \
--enable-avisynth --enable-openssl --enable-libfreetype --enable-libmfx \
--enable-libx264 --enable-libx265 --enable-libvpx \
--enable-libfdk-aac --enable-libopus --enable-libspeex --enable-libilbc \
--enable-libopenjpeg --enable-zlib
fi

if test x"$1" != x"--config"; then
if [ -z "$2" ]; then 
make -j
else
make $2
fi
fi
