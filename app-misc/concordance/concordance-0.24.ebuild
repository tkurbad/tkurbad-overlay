# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

DESCRIPTION="Linux client for programming the Logitech Harmony universal remote"
HOMEPAGE="http://www.phildev.net/concordance/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

RDEPEND="~dev-libs/libconcord-${PV}"
DEPEND="${RDEPEND}"

S="${WORKDIR}/${P}/${PN}"

src_compile() {
	emake DESTDIR="${D}" || die "make failed"
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc ../Changelog ../LICENSE README
}

pkg_postinst() {
	einfo "Set up your remote by visiting members.harmonyremote.com."
	einfo "Click 'Update Remote' to receive Connectivity.EZHex, which"
	einfo "verifies connectivity to the remote.  Run it with:"
	echo
	einfo "    concordance --connectivity-test Connectivity.EZHex"
	echo
	einfo "Return to your browser and click to the next screen to receive"
	einfo "Update.EZHex, which contains the new configuration.  Run it with:"
	echo
	einfo "    concordance --write-config Update.EZHex"
}
