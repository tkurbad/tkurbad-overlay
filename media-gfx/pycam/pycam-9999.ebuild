# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
PYTHON_COMPAT=( python2_7 )

inherit distutils-r1 python-r1 eutils

DESCRIPTION="Open Source CAM - Toolpath Generation for 3-Axis CNC machining"
HOMEPAGE="http://pycam.sourceforge.net/"

if [[ "${PV}" == "9999" ]]; then
	EGIT_REPO_URI="https://github.com/SebKuzminsky/${PN}.git"
	inherit git-r3
	KEYWORDS=""
else
	SRC_URI="https://github.com/SebKuzminsky/${PN}/archive/v${PV}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="GPL-3"
SLOT="0"

DEPEND="
	virtual/python-enum34
	dev-python/pygtk
	dev-python/pygtkglext
	dev-python/pyopengl
"
RDEPEND="${DEPEND}"
