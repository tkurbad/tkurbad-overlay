# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

DESCRIPTION="Linux GUI client for programming the Logitech Harmony universal remote"
HOMEPAGE="http://sourceforge.net/projects/congruity/"
SRC_URI="mirror://sourceforge/congruity/${P}.tar.bz2"

LICENSE="GPL"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND="dev-libs/libconcord
	dev-lang/python
	dev-python/wxpython"
RDEPEND="${DEPEND}"

src_compile() {
	sed -i "s/\/usr\/local/\/usr/g" ${S}/Makefile
	emake DESTDIR="${D}" all || die
}

src_install() {
	 emake DESTDIR="${D}" UPDATE_DESKTOP_DB="" install || die "install failed"
}
