# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=6

inherit git-r3 autotools

DESCRIPTION="Digital logic circuit design and simulation package"
HOMEPAGE="http://www.smartsim.org.uk/ https://github.com/ashleynewson/SmartSim"
SRC_URI="doc? ( http://www.smartsim.org.uk/downloads/manual/smartsim_user_manual.pdf )"
EGIT_REPO_URI="git://github.com/ashleynewson/SmartSim.git"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""
IUSE="doc"

RDEPEND="dev-libs/libxml2:2
	gnome-base/librsvg:2
	x11-libs/cairo
	x11-libs/gtk+:2"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

src_prepare() {
	default
	eautoreconf
}

src_install() {
	default
	use doc && dodoc "${DISTDIR}"/smartsim_user_manual.pdf
}
