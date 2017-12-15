TEMPLATE = app
CONFIG += console
CONFIG -= app_bundle
CONFIG -= qt

INCLUDEPATH += ..

HEADERS += \
    cmdutils.h \
    ffmpeg.h \
    ffserver_config.h

SOURCES += \
    cmdutils.c \
    cmdutils_opencl.c \
    ffmpeg.c \
    ffmpeg_cuvid.c \
    ffmpeg_filter.c \
    ffmpeg_hw.c \
    ffmpeg_opt.c \
    ffmpeg_qsv.c \
    ffmpeg_videotoolbox.c \
    ffplay.c \
    ffprobe.c \
    ffserver.c \
    ffserver_config.c
