# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

MULTILIB_COMPAT=( abi_x86_64 )

inherit multilib-build eutils

if [[ ${PV} == "9999" ]]; then
        EGIT_REPO_URI="https://github.com/volkszaehler/${PN}"
        inherit git-r3
	KEYWORDS=""
else
	SRC_URI="https://github.com/volkszaehler/${PN}/archive/${PV} -> ${P}"
	KEYWORDS="~amd64"
fi

DESCRIPTION="A library which implements the Smart Message Language (SML)"
HOMEPAGE="https://github.com/volkszaehler/libsml"

LICENSE="GPL-3"
SLOT="0"
IUSE="+examples"

RDEPEND="
	sys-apps/util-linux
"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

EMULTILIB_PKG="true"

src_prepare() {
	local lib64="$(get_libdir)"
	sed -e "s:prefix = /usr/local:prefix = /usr:" \
		-i ${S}/sml/Makefile \
	|| die "sed failed"

	sed -e "s:libdir = \${exec_prefix}/lib:libdir = \$\{exec_prefix\}/${lib64}:" \
		-i ${S}/sml/Makefile \
	|| die "sed failed"

	sed -e "s@Version: 0.1@Version: 0.9@" \
		-i ${S}/sml.pc \
	|| die "sed failed"

	if use examples ; then
		sed -e "s@prefix = /usr/local@prefix = /usr@" \
			-i ${S}/examples/Makefile \
		|| die "sed failed"
	fi

	default
}

src_compile() {
	emake -C sml
	use examples && emake -C examples
}

src_install() {
	DESTDIR="${D}" emake -C sml install
	use examples && DESTDIR="${D}" emake -C examples install
	insinto /usr/$(get_libdir)/pkgconfig
	doins ${S}/sml.pc
}

src_test() {
	emake -C test
}
