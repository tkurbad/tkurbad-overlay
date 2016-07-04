# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit eutils

DESCRIPTION="An open-source AVR electronics prototyping platform"
HOMEPAGE="http://arduino.cc/"
SRC_URI="https://github.com/arduino/Arduino/archive/${PV}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
RESTRICT="strip binchecks"

RDEPEND="
	dev-embedded/arduino-builder
	dev-embedded/avrdude
	dev-embedded/uisp"

DEPEND="
	!dev-embedded/arduino"

S="${WORKDIR}/Arduino-${PV}"
SHARE="/usr/share/${PN}"

src_prepare() {
	epatch "${FILESDIR}/${P}-platform.patch"

	cp "${FILESDIR}/platform-${PV}/"* hardware/
}

src_install() {
	insinto "${SHARE}"
	rm -fr hardware/tools
	doins -r hardware libraries
	fowners -R root:uucp "${SHARE}"

	# Use system arduino-builder
	dosym /usr/bin/arduino-builder "${SHARE}/arduino-builder"

	# Install examples (NOT optional, needed for application startup)
	doins -r "${S}/build/shared/examples"

	# hardware/tools/avr needs to exist or arduino-builder will
	# complain about missing required -tools arg
	dodir "${SHARE}/hardware/tools/avr"
}
