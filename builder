#!/usr/bin/env bash

set -eo pipefail; [[ "$TRACE" ]] && set -x


main() {
	declare version="${1:-$GLIBC_VERSION}" prefix="${2:-$PREFIX_DIR}" arch="${3:-$ARCH}"

	: "${version:?}" "${prefix:?}"

	{
		wget -qO- "https://ftpmirror.gnu.org/libc/glibc-$version.tar.gz" \
			| tar zxf -
		git apply /patches/*.diff
		mkdir -p /glibc-build && cd /glibc-build
		"/glibc-$version/configure" \
			--prefix="$prefix" \
			--libdir="$prefix/lib" \
			--libexecdir="$prefix/lib" \
			--host=${arch} \
			--enable-multi-arch \
			--enable-stack-protector=strong \
			--disable-werror  # GCC 9.X Fix - https://github.com/cirosantilli/linux-kernel-module-cheat/issues/97
		ls -l
		make && make install 
		tar --dereference --hard-dereference -zcf "/glibc-bin-$version-$arch.tar.gz" "$prefix"
	} >&2

	[[ $STDOUT ]] && cat "/glibc-bin-$version-$arch.tar.gz"
}

main "$@"
