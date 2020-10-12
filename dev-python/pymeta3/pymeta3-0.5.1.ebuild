# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6
PYTHON_COMPAT=( python3_{6,7,8,9} pypy3 )
DISTUTILS_USE_SETUPTOOLS=no

MY_PN="PyMeta3"
MY_P="${MY_PN}-${PV}"

inherit distutils-r1

DESCRIPTION="Pattern-matching language based on OMeta for Python"
HOMEPAGE="https://github.com/wbond/pymeta3"
SRC_URI="mirror://pypi/${MY_P:0:1}/${MY_PN}/${MY_P}.tar.gz -> ${P}.tar.gz"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=""
DEPEND="${RDEPEND}"

S="${WORKDIR}/${MY_P}"
