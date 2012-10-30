# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4
inherit eutils toolchain-funcs

MY_P="concordance-${PV}"

DESCRIPTION="Library for programming the Logitech Harmony universal remote; part
of the concordance project"
HOMEPAGE="http://www.phildev.net/concordance/"
SRC_URI="mirror://sourceforge/concordance/${MY_P}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

RDEPEND=">=dev-libs/libusb-0.1.12-r1"
DEPEND="${RDEPEND}"
	
S="${WORKDIR}/${MY_P}/${PN}"

src_compile() {
	emake DESTDIR="${D}" || die "make failed"
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc ../Changelog ../LICENSE README

	cd "${S}"/bindings/python
	python setup.py install --root=${D}
}
