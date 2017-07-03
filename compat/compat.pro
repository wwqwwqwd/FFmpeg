CONFIG -= qt

TARGET = compat
TEMPLATE = lib

INCLUDEPATH += ..

HEADERS += \
    cuda/dynlink_cuda.h \
    cuda/dynlink_cuviddec.h \
    cuda/dynlink_loader.h \
    cuda/dynlink_nvcuvid.h \
    nvenc/nvEncodeAPI.h
