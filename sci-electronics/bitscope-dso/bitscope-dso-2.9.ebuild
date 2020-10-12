# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit desktop eutils udev unpacker xdg

VERSION_TAG="V23KG6ZT"
MY_PV="${PV}.${VERSION_TAG}"
MY_P="${PN}_${MY_PV}"

SRC_URI="amd64? ( http://bitscope.com/download/files/${MY_P}_amd64.deb )"

DESCRIPTION="BitScope DSO for the BitScope PC oscilloscopes."

HOMEPAGE="http://www.bitscope.com/software/dso"
IUSE=""
SLOT="0"

KEYWORDS="-* ~amd64"
LICENSE=""
RESTRICT=""

RDEPEND=">=dev-libs/atk-1.12.4
	>=dev-libs/glib-2.12.0
	sys-libs/libcap
	>=x11-libs/cairo-1.2.4
	x11-libs/gtk+:2
	>=x11-libs/pango-1.14.0
	x11-libs/libX11"

S="${WORKDIR}"

src_unpack() {
	unpack_deb ${A}
}

src_prepare() {
	default

	sed -i "s/Icon=bitscope-dso\.png/Icon=bitscope-dso/" \
		"${S}"/usr/share/applications/${PN}.desktop

	gunzip -r "${S}"/usr/share/doc/${PN}/
}

src_install() {
	insinto /etc/bitscope
	doins -r /etc/bitscope

	udev_dorules etc/udev/rules.d/77-bitscope.rules

	dobin usr/bin/${PN}
	dobin usr/bin/start-${PN}
	dodoc -r usr/share/doc/${PN}/*
	doicon usr/share/pixmaps/${PN}.png
	domenu usr/share/applications/${PN}.desktop
}
