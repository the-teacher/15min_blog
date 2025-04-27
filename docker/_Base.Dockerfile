# Rails. Start Kit (https://github.com/the-teacher/rails-startkit)
# Rails. 15 min Blog. (https://github.com/the-teacher/15min_blog)
# 
# Image with the most common software

# Ruby version to use
ARG RUBY_VERSION=3.4.3-bookworm

# https://github.com/shssoichiro/oxipng/releases
ARG OXIPNG_VERSION=9.1.5
# https://www.ijg.org/files
ARG JPEG_VERSION=9f
# https://github.com/mozilla/mozjpeg/releases
ARG MOZJPEG_VERSION=4.1.1
# https://github.com/danielgtaylor/jpeg-archive/releases
ARG JPEGARCHIVE_VERSION=2.2.0
# https://pngquant.org/releases.html
# https://raw.githubusercontent.com/kornelski/pngquant/main/CHANGELOG
ARG PNGQUANT_VERSION=2.18.0
# http://www.jonof.id.au/kenutils
ARG PNGOUT_VERSION=20200115
# https://github.com/amadvance/advancecomp/releases
ARG ADVANCECOMP_VERSION=2.6
# https://github.com/tjko/jpegoptim/releases
ARG JPEGOPTIM_VERSION=1.5.5

# STAGE | BASE DEBIAN
FROM --platform=$BUILDPLATFORM ruby:${RUBY_VERSION} AS base_debian
RUN apt-get update && apt-get install -y build-essential cmake nasm bash findutils

# STAGE | BASE RUST
FROM --platform=$BUILDPLATFORM rust:1 AS base_rust
RUN apt-get update && apt-get install -y build-essential

# STAGE | oxipng
# amd 64 ? <jemalloc>: MADV_DONTNEED does not work (memset will be used instead)
# amd 64 ? <jemalloc>: (This is the expected behaviour if you are running under QEMU)
FROM base_rust AS oxipng

ARG OXIPNG_VERSION
RUN wget -O oxipng-${OXIPNG_VERSION}.tar.gz https://github.com/shssoichiro/oxipng/archive/refs/tags/v${OXIPNG_VERSION}.tar.gz
RUN tar -xvzf oxipng-${OXIPNG_VERSION}.tar.gz
WORKDIR /oxipng-${OXIPNG_VERSION}
RUN cargo build --release; exit 0
RUN cargo build --release
RUN install -c target/release/oxipng /usr/local/bin

# STAGE | jpegtran
FROM base_debian AS libjpeg

ARG JPEG_VERSION
RUN wget -O jpegsrc.v${JPEG_VERSION}.tar.gz https://www.ijg.org/files/jpegsrc.v${JPEG_VERSION}.tar.gz
RUN tar -xvzf jpegsrc.v${JPEG_VERSION}.tar.gz
RUN cd jpeg-${JPEG_VERSION} && \
    ./configure && \
    make install

# STAGE | LIB MOZ JPEG (common)
FROM base_debian AS libmozjpeg

ARG MOZJPEG_VERSION
RUN wget -O mozjpeg-${MOZJPEG_VERSION}.tar.gz https://github.com/mozilla/mozjpeg/archive/v${MOZJPEG_VERSION}.tar.gz
RUN tar -xvzf mozjpeg-${MOZJPEG_VERSION}.tar.gz
RUN cd mozjpeg-${MOZJPEG_VERSION} && \
    cmake -DPNG_SUPPORTED=0 . && \
    make install

# STAGE | jpeg-recompress
FROM libmozjpeg AS jpegarchive

ARG JPEGARCHIVE_VERSION
RUN wget -O jpegarchive-${JPEGARCHIVE_VERSION}.tar.gz https://github.com/danielgtaylor/jpeg-archive/archive/v${JPEGARCHIVE_VERSION}.tar.gz
RUN tar -xvzf jpegarchive-${JPEGARCHIVE_VERSION}.tar.gz
RUN cd jpeg-archive-${JPEGARCHIVE_VERSION} && \
    CFLAGS=-fcommon make install

# STAGE | pngquant
FROM base_debian AS pngquant

ARG PNGQUANT_VERSION
RUN wget -O pngquant-${PNGQUANT_VERSION}.tar.gz https://pngquant.org/pngquant-${PNGQUANT_VERSION}-src.tar.gz
RUN tar -xvzf pngquant-${PNGQUANT_VERSION}.tar.gz
RUN cd pngquant-${PNGQUANT_VERSION} && \
    make install

# STAGE | pngout-static
FROM base_debian AS pngout-static

ARG PNGOUT_VERSION
RUN wget -O pngout-${PNGOUT_VERSION}-linux-static.tar.gz http://www.jonof.id.au/files/kenutils/pngout-${PNGOUT_VERSION}-linux-static.tar.gz
RUN tar -xvzf pngout-${PNGOUT_VERSION}-linux-static.tar.gz
RUN cd pngout-${PNGOUT_VERSION}-linux-static && \
    cp amd64/pngout-static /usr/local/bin/pngout

# STAGE | advpng
FROM base_debian AS advancecomp

ARG ADVANCECOMP_VERSION
RUN wget -O advancecomp-${ADVANCECOMP_VERSION}.tar.gz https://github.com/amadvance/advancecomp/releases/download/v${ADVANCECOMP_VERSION}/advancecomp-${ADVANCECOMP_VERSION}.tar.gz
RUN tar -xvzf advancecomp-${ADVANCECOMP_VERSION}.tar.gz
RUN cd advancecomp-${ADVANCECOMP_VERSION} && \
    ./configure && \
    make install

# STAGE | MAIN
FROM --platform=$BUILDPLATFORM ruby:${RUBY_VERSION}

ARG TARGETARCH
ARG BUILDPLATFORM
ARG RUBY_VERSION
ARG JPEGOPTIM_VERSION

RUN echo "$BUILDPLATFORM" > /BUILDPLATFORM
RUN echo "$TARGETARCH" > /TARGETARCH
RUN echo "$RUBY_VERSION" > /RUBY_VERSION

# =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
# PRECOMPILED IMG PROCESSORS
# =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

COPY --from=advancecomp   /usr/local/bin/advpng          /usr/bin
COPY --from=oxipng        /usr/local/bin/oxipng          /usr/bin
COPY --from=pngquant      /usr/local/bin/pngquant        /usr/bin
COPY --from=pngout-static /usr/local/bin/pngout          /usr/bin

COPY --from=jpegarchive  /usr/local/bin/jpeg-recompress  /usr/bin

COPY --from=libjpeg      /usr/local/bin/jpegtran         /usr/bin
COPY --from=libjpeg      /usr/local/lib/libjpeg.so.9     /usr/lib

# =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
# PRECOMPILED IMG PROCESSORS
# =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

RUN apt-get update && apt-get install --yes \
    gifsicle \
    jhead \
    optipng \
    pngcrush

# =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
# JPEGOPTIM
# =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

WORKDIR /tmp

RUN wget -O jpegoptim-${JPEGOPTIM_VERSION}.tar.gz https://github.com/tjko/jpegoptim/archive/v${JPEGOPTIM_VERSION}.tar.gz
RUN tar -xvzf jpegoptim-${JPEGOPTIM_VERSION}.tar.gz

RUN cd jpegoptim-${JPEGOPTIM_VERSION} && \
    ./configure && \
    make install

RUN rm -rf jpegoptim-${JPEGOPTIM_VERSION}*

WORKDIR /

# =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
# COMMON
# =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

RUN apt-get update && apt-get install --yes \
    telnet \
    cron \
    vim

# =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
# IMG PROCESSORS TEST
# =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

RUN mkdir -p /tmp/image_optim
COPY docker/test/image_processors.sh /tmp/image_optim/image_processors.sh