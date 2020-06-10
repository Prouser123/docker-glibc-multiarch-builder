FROM ubuntu:19.04
MAINTAINER Sasha Gerrand <github+docker-glibc-builder@sgerrand.com>

ENV PREFIX_DIR /usr/glibc-compat
ENV GLIBC_VERSION 2.31
ENV ARCH x86_64-linux

RUN export DEBIAN_FRONTEND=noninteractive \
    && sed -i 's/http:\/\/archive.ubuntu.com/http:\/\/old-releases.ubuntu.com/;s/http:\/\/security.ubuntu.com/http:\/\/old-releases.ubuntu.com/' /etc/apt/sources.list \
    && apt-get -q update \
	&& apt-get -qy install \
		bison \
		build-essential \
		gawk \
		gettext \
		openssl \
		python3 \
		texinfo \
		wget \
		# arm64v8 Linux
		gcc-aarch64-linux-gnu g++-aarch64-linux-gnu\
		# armel (armv4t) Linux
		gcc-arm-linux-gnueabi g++-arm-linux-gnueabi\
		# armhf (armv7) Linux
		gcc-arm-linux-gnueabihf g++-arm-linux-gnueabihf\
		# GIT
		git \
	&& wget https://patchwork.ozlabs.org/project/buildroot/patch/20170803213027.27565-1-thomas.petazzoni@free-electrons.com/raw/ -O /patch.diff
COPY configparams /glibc-build/configparams
COPY builder /builder
ENTRYPOINT ["/builder"]
