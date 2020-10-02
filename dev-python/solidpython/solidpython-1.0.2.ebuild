# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6
PYTHON_COMPAT=( python3_{7,8,9} pypy3 )
DISTUTILS_USE_SETUPTOOLS=bdepend

inherit distutils-r1

DESCRIPTION="OpenSCAD for Python"
HOMEPAGE="https://github.com/SolidCode/SolidPython"
KEYWORDS="~amd64 ~x86"
SRC_URI="mirror://pypi/${P:0:1}/${PN}/${P}.tar.gz"

LICENSE="LGPL"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-python/euclid3-0.01[${PYTHON_USEDEP}]
	>=dev-python/pypng-0.0.19[${PYTHON_USEDEP}]
	~dev-python/prettytable-0.7.2[${PYTHON_USEDEP}]
	>=dev-python/regex-2019.4[${PYTHON_USEDEP}]
"

DEPEND="${RDEPEND}"

src_prepare() {
	# Sanitize dependency versions
	sed -e "s/,<0.2.0//" \
		-e "s/,<0.0.20//" \
		-e "s/,<2020.0//" \
		-i "${S}"/setup.py || die "sed failed"

	default
}
