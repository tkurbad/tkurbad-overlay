# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6
PYTHON_COMPAT=( python{2_7,3_4,3_5,3_6} pypy )

inherit distutils-r1

MY_PN="${PN/_/.}"

DESCRIPTION="Path commands in SVG and parser for SVG path definitions."
HOMEPAGE="https://github.com/regebro/svg.path"
SRC_URI="https://github.com/regebro/${MY_PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND=""
DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]
	${RDEPEND}"

S="${WORKDIR}/${MY_PN}-${PV}"
