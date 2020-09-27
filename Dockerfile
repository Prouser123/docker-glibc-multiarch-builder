FROM ubuntu:20.04
MAINTAINER Sasha Gerrand <github+docker-glibc-builder@sgerrand.com>
ENV PREFIX_DIR /usr/glibc-compat
ENV GLIBC_VERSION 2.27
RUN export DEBIAN_FRONTEND=noninteractive \
	&& apt-get -q update \
	&& apt-get -qy install \
		bison \
		build-essential \
		wget \
		openssl \
		gawk \
		# arm64v8 Linux
		gcc-aarch64-linux-gnu g++-aarch64-linux-gnu \
		# armel (armv4t) Linux
		gcc-arm-linux-gnueabi g++-arm-linux-gnueabi \
		# armhf (armv7) Linux
		gcc-arm-linux-gnueabihf g++-arm-linux-gnueabihf \
		# s390x Linux
		gcc-s390x-linux-gnu g++-s390x-linux-gnu \
		# ppc64le (ppc64el) Linux
		gcc-powerpc64le-linux-gnu g++-powerpc64le-linux-gnu \
		# GIT
		git
COPY patches /patches
COPY configparams /glibc-build/configparams
COPY builder /builder
ENTRYPOINT ["/builder"]
