# Copyright 1999-2020 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
inherit ltprune

if [[ ${PV} == "9999" ]] ; then
        inherit autotools subversion
	ESVN_REPO_URI="https://svn.code.sf.net/p/gpsim/code/trunk"
else
	SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
	KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
fi


DESCRIPTION="A simulator for the Microchip PIC microcontrollers"
HOMEPAGE="http://gpsim.sourceforge.net"

LICENSE="GPL-2"
SLOT="0"
IUSE="doc gtk static-libs"

RDEPEND=">=dev-embedded/gputils-0.12
	dev-libs/glib:2
	dev-libs/popt
	sys-libs/readline:0=
	gtk? ( >=x11-libs/gtk+extra-2 )"
DEPEND="${RDEPEND}
	sys-devel/flex
	virtual/pkgconfig
	virtual/yacc"

DOCS=( ANNOUNCE AUTHORS ChangeLog HISTORY PROCESSORS README README.MODULES TODO )

src_prepare() {
	default

	if [[ ${PV} == "9999" ]] ; then
		eautoreconf
	fi
}

src_configure() {
	econf \
		--enable-leak-sanitize \
		--enable-address-sanitize \
		--enable-undefined-sanitize \
		$(use_enable gtk gui) \
		$(use_enable static-libs static)
}

src_install() {
	default
	use doc && dodoc doc/gpsim.pdf
	prune_libtool_files
}
