CONFIG -= qt

TARGET = libavcodec
TEMPLATE = lib

INCLUDEPATH += .. ../../aac.build ../../x264 ../../openssl/include

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
    libopenjpegenc.c \
    nvenc.c \
    nvenc_h264.c \
    nvenc_hevc.c \
    libx264.c \
    libx265.c \
    libfdk-aacdec.c \
    libfdk-aacenc.c \
    encode.c \
    bsf.c \
    bsf_list.c \
    chomp_bsf.c \
    aac_adtstoasc_bsf.c \
    dump_extradata_bsf.c \
    extract_extradata_bsf.c \
    h264_mp4toannexb_bsf.c \
    hevc_mp4toannexb_bsf.c \
    imx_dump_header_bsf.c \
    encrypt_bsf.c \
    bitstream_filter.c \
    bitstream_filters.c

HEADERS += \
    mpegaudio.h \
    hevc_parse.h \
    hevcdec.h \
    internal.h \
    avcodec.h \
    bsf.h \
    nvenc.h \
    bsf.h
