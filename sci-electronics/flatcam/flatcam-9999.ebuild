# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6
PYTHON_COMPAT=( python2_7 )

inherit distutils-r1 git-r3 gnome2-utils

DESCRIPTION="Free and Open-source PCB CAM.."
HOMEPAGE="http://flatcam.org"

if [[ "${PV}" == "9999" ]] ; then
	inherit git-r3
	EGIT_REPO_URI="https://bitbucket.org/jpcgt/${PN}.git"
	KEYWORDS=""
	SRC_URI=""
else
	SRC_URI="https://bitbucket.org/jpcgt/flatcam/downloads/FlatCAM-${PV}.zip -> ${P}.zip"
	KEYWORDS="amd64 x86"
fi

LICENSE="MIT"
SLOT="0"
IUSE="+doc"

RDEPEND="
	>=dev-python/matplotlib-1.3.1[qt5]
	>=dev-python/numpy-1.8
	dev-python/PyQt5
	dev-python/simplejson
	dev-python/svg_path
	sci-libs/Rtree
	sci-libs/scipy
	>=sci-libs/Shapely-1.3
	"
DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]
	${RDEPEND}"

src_compile() {
	distutils-r1_src_install

	if use doc ; then
		cd "${S}"/doc
		emake html
	fi
}

src_install() {
	distutils-r1_src_install

	insinto /usr/share/applications
	doins "${S}"/flatcam.desktop

	local size
	for size in 16 24 32 48 128 256; do
		dosym ../../../../${PN}/${PN}_icon${size}.png \
			/usr/share/icons/hicolor/${size}x${size}/apps/flatcam.png
	done

	use doc && dodoc -r "${S}"/doc/build/html
}

pkg_postrm() {
	gnome2_icon_cache_update
}

pkg_postinst() {
	gnome2_icon_cache_update
}
