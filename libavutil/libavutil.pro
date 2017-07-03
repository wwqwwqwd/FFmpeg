CONFIG -= qt

TARGET = libavutil
TEMPLATE = lib

INCLUDEPATH += ..

SOURCES += \
    utils.c \
    samplefmt.c \
    buffer.c \
    fifo.c \
    hwcontext.c \
    hwcontext_cuda.c \
    log.c \
    opt.c \
    pixdesc.c \
    mem.c \
    mathematics.c \
    mastering_display_metadata.c \
    frame.c

HEADERS += \
    internal.h \
    samplefmt.h \
    buffer.h \
    buffer_internal.h \
    fifo.h \
    hwcontext.h \
    hwcontext_cuda.h \
    hwcontext_cuda_internal.h \
    log.h \
    opt.h \
    pixdesc.h \
    hwcontext_internal.h \
    mem.h \
    mem_internal.h \
    mathematics.h \
    mastering_display_metadata.h \
    frame.h
