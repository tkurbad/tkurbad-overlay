# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6
PYTHON_COMPAT=( python3_{7,8,9} pypy3 )
DISTUTILS_USE_SETUPTOOLS=rdepend

MY_PN="KiKit"
MY_P="${MY_PN}-${PV}"

inherit distutils-r1

DESCRIPTION="KiKit is a Python library and CLI tool to automate several tasks in a standard KiCAD workflow"
HOMEPAGE="https://github.com/yaqwsx/KiKit"
if [[ ${PV} == "9999" ]] ; then
        EGIT_REPO_URI="https://github.com/yaqwsx/KiKit.git"
        KEYWORDS=""
        inherit git-r3
else
        KEYWORDS="~amd64 ~x86"
	SRC_URI="mirror://pypi/${MY_P:0:1}/${MY_PN}/${MY_P}.tar.gz -> ${P}.tar.gz"
fi

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND="dev-python/click[${PYTHON_USEDEP}]
	dev-python/markdown2[${PYTHON_USEDEP}]
	dev-python/numpy[${PYTHON_USEDEP}]
	dev-python/pybars3[${PYTHON_USEDEP}]
	dev-python/solidpython[${PYTHON_USEDEP}]
	sci-libs/Shapely[${PYTHON_USEDEP}]
"

DEPEND="${RDEPEND}
	dev-python/versioneer[${PYTHON_USEDEP}]
"
