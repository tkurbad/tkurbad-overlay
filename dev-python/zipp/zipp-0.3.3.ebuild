# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6
PYTHON_COMPAT=( python{2_7,3_6} )

inherit distutils-r1

DESCRIPTION="A pathlib-compatible Zipfile object wrapper."
HOMEPAGE="https://github.com/jaraco/zipp"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND=""
DEPEND="${RDEPEND}"
