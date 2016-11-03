# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit multilib

DESCRIPTION="Calculate GCode from given PCB layouts"
HOMEPAGE="http://sourceforge.net/apps/mediawiki/pcb2gcode/"

if [[ ${PV} == "9999" ]] ; then
	EGIT_REPO_URI="https://github.com/pcb2gcode/pcb2gcode.git"
	KEYWORDS=""
	inherit autotools-utils autotools eutils git-r3
else
	KEYWORDS="~amd64 ~x86"
	SRC_URI="https://github.com/${PN}/${PN}/releases/download/v${PV}/${P}.tar.gz"
fi

RESTRICT="nomirror"

LICENSE="GPL-2"
SLOT="0"
IUSE=""

RDEPEND="sci-electronics/gerbv"
DEPEND="${RDEPEND}"

src_prepare() {
	if [[ ${PV} == "9999" ]] ; then
		eautoreconf -i
	fi
}

src_install() {
	cd "${BUILD_DIR}"
	exeinto /usr/bin
	doexe pcb2gcode

	cd "${S}"
	doman man/pcb2gcode.1
	dodoc AUTHORS COPYING
}
