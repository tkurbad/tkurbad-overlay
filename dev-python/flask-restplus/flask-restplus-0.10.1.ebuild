# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6
PYTHON_COMPAT=( python{2_7,3_6,3_7} pypy{,3} )

inherit distutils-r1

DESCRIPTION="Fully featured framework for fast, easy and documented API development with Flask"
HOMEPAGE="http://flask-restplus.readthedocs.org/ https://github.com/noirbizarre/flask-restplus/"
SRC_URI="https://github.com/noirbizarre/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="doc examples test"

RDEPEND="
	~dev-python/aniso8601-4.0.1[${PYTHON_USEDEP}]
	>=dev-python/flask-0.8[${PYTHON_USEDEP}]
	>=dev-python/six-1.3.0[${PYTHON_USEDEP}]
	dev-python/pytz[${PYTHON_USEDEP}]
	dev-python/jsonschema[${PYTHON_USEDEP}]
	>=dev-python/flask-restful-0.3.3[${PYTHON_USEDEP}]
"
DEPEND="${RDEPEND}
	dev-python/sphinx[${PYTHON_USEDEP}]
	test? (
		dev-python/nose[${PYTHON_USEDEP}]
		dev-python/rednose[${PYTHON_USEDEP}]
		dev-python/blinker[${PYTHON_USEDEP}]
		dev-python/tzlocal[${PYTHON_USEDEP}]
	)
"

src_prepare() {
	use test || rm -rf "${S}"/tests

	distutils-r1_src_prepare
}

python_test() {
	nosetests -v || die "Tests fail with ${EPYTHON}"
	rm -rf "${BUILD_DIR}"/../tests/ || die
}
