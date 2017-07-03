CONFIG -= qt

TARGET = libavdevice
TEMPLATE = lib

INCLUDEPATH += ..

SOURCES += \
    utils.c \
    avdevice.c

HEADERS += \
    internal.h \
    avdevice.h
