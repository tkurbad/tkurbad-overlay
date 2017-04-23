# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5
PYTHON_COMPAT=( python{2_7,3_4,3_5} pypy )

inherit distutils-r1

DESCRIPTION="A realistic password strength estimator."
HOMEPAGE="https://github.com/dwolfhub/zxcvbn-python"
SRC_URI="https://github.com/dwolfhub/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND=">=dev-python/py-1.4.31[${PYTHON_USEDEP}]
	>=dev-python/pytest-3.0.4[${PYTHON_USEDEP}] 
"
DEPEND="${RDEPEND}"
