CONFIG -= qt

TARGET = libavcodec
TEMPLATE = lib

INCLUDEPATH += ..

SOURCES += \
    mpegaudio.c \
    mpegaudiodec_fixed.c \
    mpegaudiodec_float.c \
    mpegaudiodec_template.c \
    mpegaudio_parser.c \
    hevc_parse.c \
    hevcdec.c \
    mpegaudiodecheader.c \
    utils.c \
    options.c \
    cuvid.c \
    8bps.c \
    decode.c \
    bsf.c \
    avpacket.c \
    jpeg2000.c \
    libopenjpegdec.c \
    libopenjpegenc.c

HEADERS += \
    mpegaudio.h \
    hevc_parse.h \
    hevcdec.h \
    internal.h \
    avcodec.h \
    bsf.h
