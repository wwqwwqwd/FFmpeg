CONFIG -= qt

TARGET = libavformat
TEMPLATE = lib

INCLUDEPATH += ..

SOURCES += \
    avidec.c \
    riff.c \
    riffdec.c \
    utils.c \
    avio.c \
    aviobuf.c \
    mov.c \
    mov_chan.c \
    isom.c \
    avienc.c \
    avidec.c \
    avienc.c

HEADERS += \
    avi.h \
    riff.h \
    internal.h \
    avformat.h \
    avio.h \
    avio_internal.h \
    mov_chan.h \
    isom.h \
    avi.h

DISTFILES +=
