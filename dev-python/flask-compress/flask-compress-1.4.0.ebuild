# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6
PYTHON_COMPAT=( python3_{6,7} pypy3 )

MY_PN="Flask-Compress"
MY_P="${MY_PN}-${PV}"

inherit distutils-r1

DESCRIPTION="Flask-Compress allows you to easily compress your Flask application's responses with gzip."
HOMEPAGE="https://github.com/libwilliam/flask-compress"
SRC_URI="mirror://pypi/${MY_P:0:1}/${MY_PN}/${MY_P}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND=">=dev-python/flask-0.9[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}"

S="${WORKDIR}/${MY_P}"
