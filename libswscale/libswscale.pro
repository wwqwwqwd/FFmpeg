CONFIG -= qt

TARGET = libswscale
TEMPLATE = lib

INCLUDEPATH += ..

HEADERS += \
    rgb2rgb.h \
    swscale.h \
    swscale_internal.h \
    version.h

SOURCES += \
    alphablend.c \
    bayer_template.c \
    gamma.c \
    hscale.c \
    hscale_fast_bilinear.c \
    input.c \
    log2_tab.c \
    options.c \
    output.c \
    rgb2rgb.c \
    rgb2rgb_template.c \
    slice.c \
    swscale.c \
    swscale_unscaled.c \
    utils.c \
    vscale.c \
    yuv2rgb.c
