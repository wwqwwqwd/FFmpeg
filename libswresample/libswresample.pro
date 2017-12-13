CONFIG -= qt

TARGET = libswresample
TEMPLATE = lib

INCLUDEPATH += ..

HEADERS += \
    audioconvert.h \
    resample.h \
    swresample.h \
    swresample_internal.h \
    version.h

SOURCES += \
    audioconvert.c \
    dither.c \
    dither_template.c \
    log2_tab.c \
    noise_shaping_data.c \
    options.c \
    rematrix.c \
    rematrix_template.c \
    resample.c \
    resample_dsp.c \
    resample_template.c \
    soxr_resample.c \
    swresample.c \
    swresample_frame.c \
    audioconvert.c \
    dither.c \
    dither_template.c \
    log2_tab.c \
    noise_shaping_data.c \
    options.c \
    rematrix.c \
    rematrix_template.c \
    resample.c \
    resample_dsp.c \
    resample_template.c \
    soxr_resample.c \
    swresample.c \
    swresample_frame.c
