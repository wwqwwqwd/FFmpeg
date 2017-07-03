TEMPLATE = app
CONFIG += console
CONFIG -= app_bundle
CONFIG -= qt

INCLUDEPATH += ../..

SOURCES += \
    avio_dir_cmd.c \
    avio_reading.c \
    decode_audio.c \
    decode_video.c \
    demuxing_decoding.c \
    encode_audio.c \
    encode_video.c \
    extract_mvs.c \
    filter_audio.c \
    filtering_audio.c \
    filtering_video.c \
    http_multiclient.c \
    metadata.c \
    muxing.c \
    qsvdec.c \
    remuxing.c \
    resampling_audio.c \
    scaling_video.c \
    transcode_aac.c \
    transcoding.c
