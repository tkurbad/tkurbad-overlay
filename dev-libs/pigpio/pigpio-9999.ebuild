# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

PYTHON_COMPAT=( python3_{7,8,9} pypy3 )
DISTUTILS_OPTIONAL=1
DISTUTILS_USE_SETUPTOOLS=no
inherit eutils git-r3 toolchain-funcs distutils-r1

DESCRIPTION="C library for the Raspberry allowing control of general purpose input outputs"
HOMEPAGE="http://abyz.co.uk/rpi/pigpio"
EGIT_REPO_URI="https://github.com/joan2937/${PN}"

LICENSE="public-domain"
SLOT="0"
KEYWORDS=""
IUSE="examples python remote"

RDEPEND="python? ( ${PYTHON_DEPS} )"
DEPEND="${RDEPEND}"
REQUIRED_USE="python? ( ${PYTHON_REQUIRED_USE} )"

src_prepare() {
	default
	epatch \
		"${FILESDIR}"/${P}-Makefile.patch \
		"${FILESDIR}"/${PN}-44-MakeRemote.patch
		# "${FILESDIR}"/${PN}-44-format-security.patch \

	tc-export CC AR RANLIB
	export SIZE="$(tc-getAR)"
	export SIZE="${SIZE/-ar/-size}"
	export SHLIB="$(tc-getCC) -shared"
	export STRIPLIB="true"

	use python && distutils-r1_src_prepare
}

src_configure() {
	use python && distutils-r1_src_configure
}

src_compile() {
	if use remote ; then
		emake -f MakeRemote libpigpiod_if.so
		emake -f MakeRemote libpigpiod_if2.so
		emake -f MakeRemote
	else
		emake
	fi

	use python && distutils-r1_src_compile
}

src_install() {
	if use remote ; then
		emake -f MakeRemote install prefix="${EROOT}"usr libdir="$(get_libdir)" DESTDIR="${D}"
	else
		emake install prefix="${EROOT}"usr libdir="$(get_libdir)" DESTDIR="${D}"
	fi

	use python && distutils-r1_src_install

	if use examples ; then
		dodoc -r EXAMPLES
	fi
}
