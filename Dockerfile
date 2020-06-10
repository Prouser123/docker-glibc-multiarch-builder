FROM ubuntu:20.04
MAINTAINER Sasha Gerrand <github+docker-glibc-builder@sgerrand.com>

ENV PREFIX_DIR /usr/glibc-compat
ENV GLIBC_VERSION 2.31
ENV ARCH x86_64-linux

RUN apt-get -q update \
	&& apt-get -qy install \
		bison \
		build-essential \
		gawk \
		gettext \
		openssl \
		python3 \
		texinfo \
		wget \
		gcc-aarch64-linux-gnu \
		gcc-arm-linux-gnueabi
COPY configparams /glibc-build/configparams
COPY builder /builder
ENTRYPOINT ["/builder"]
