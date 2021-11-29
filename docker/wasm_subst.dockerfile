FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive

# https://developers.eos.io/welcome/latest/getting-started/development-environment/introduction

RUN apt-get update && apt-get install -y \
    git \
    wget \
    make \
    curl \
    sudo \
    ruby \
    cmake \
    clang \
    python3 \
    libtool \
    doxygen \
    autoconf \
    automake \
    graphviz \
    python2.7 \
    pkg-config \
    llvm-7-dev \
    zlib1g-dev \
    libicu-dev \
    libbz2-dev \
    libssl-dev \
    libgmp3-dev \
    python3-dev \
    libncurses5 \
    python2.7-dev \
    autotools-dev \
    build-essential \
    libusb-1.0-0-dev \
    libboost-all-dev \
    libcurl4-gnutls-dev

WORKDIR /root

RUN git clone --branch backport --recursive https://github.com/guilledk/eos.git

WORKDIR /root/eos

RUN mkdir -p /usr/opt/eosio
RUN scripts/eosio_build.sh -y -i /usr/opt/eosio -s TLOS
RUN scripts/eosio_install.sh
ENV PATH /usr/opt/eosio/bin:$PATH

WORKDIR /root
RUN rm -rfd /root/eos

RUN wget https://github.com/EOSIO/eosio.cdt/releases/download/v1.7.0/eosio.cdt_1.7.0-1-ubuntu-18.04_amd64.deb

RUN apt-get install -y ./eosio.cdt_1.7.0-1-ubuntu-18.04_amd64.deb

COPY wasm_substitution/ /root/wasm_substitution

WORKDIR /root/wasm_substitution
RUN cmake .
RUN make -j2
