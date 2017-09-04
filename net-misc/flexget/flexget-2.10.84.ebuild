# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

PYTHON_COMPAT=( python2_7 )

inherit distutils-r1 eutils

if [[ ${PV} != 9999 ]]; then
	MY_P="FlexGet-${PV}"
	SRC_URI="mirror://pypi/F/FlexGet/${MY_P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
else
	inherit git-r3
	EGIT_REPO_URI="git://github.com/Flexget/Flexget.git
		https://github.com/Flexget/Flexget.git"
fi

DESCRIPTION="Multipurpose automation tool for content like torrents, nzbs, podcasts, comics"
HOMEPAGE="http://flexget.com/"

LICENSE="MIT"
SLOT="0"
IUSE="test transmission"

RESTRICT="nomirror"

DEPEND="
	dev-python/setuptools[${PYTHON_USEDEP}]
	>=dev-python/rebulk-0.8.2[${PYTHON_USEDEP}]
	>=dev-python/feedparser-5.2.1[${PYTHON_USEDEP}]
	>=dev-python/sqlalchemy-1.1.10[${PYTHON_USEDEP}]
	>=dev-python/pyyaml-3.12[${PYTHON_USEDEP}]
	>=dev-python/beautifulsoup-4.6.0:4[${PYTHON_USEDEP}]
	=dev-python/html5lib-0.999999999[${PYTHON_USEDEP}]
	>=dev-python/PyRSS2Gen-1.1[${PYTHON_USEDEP}]
	>=dev-python/pynzb-0.1.0[${PYTHON_USEDEP}]
	>=dev-python/rpyc-3.3.0[${PYTHON_USEDEP}]
	>=dev-python/jinja-2.9.6[${PYTHON_USEDEP}]
	>=dev-python/requests-2.8.0[${PYTHON_USEDEP}]
	<dev-python/requests-3.0[${PYTHON_USEDEP}]
	>=dev-python/python-dateutil-2.6.1[${PYTHON_USEDEP}]
	>=dev-python/jsonschema-2.6.0[${PYTHON_USEDEP}]
	>=dev-python/colorclass-2.2.0[${PYTHON_USEDEP}]
	>=dev-python/terminaltables-3.1.0[${PYTHON_USEDEP}]
	>=dev-python/path-py-10.3.1[${PYTHON_USEDEP}]
	=dev-python/guessit-2.0.4[${PYTHON_USEDEP}]
	>=dev-python/cherrypy-10.2.2[${PYTHON_USEDEP}]
	>=dev-python/flask-0.12.2[${PYTHON_USEDEP}]
	>=dev-python/flask-restful-0.3.6[${PYTHON_USEDEP}]
	=dev-python/flask-restplus-0.10.1[${PYTHON_USEDEP}]
	>=dev-python/flask-compress-1.4.0[${PYTHON_USEDEP}]
	>=dev-python/flask-login-0.4.0[${PYTHON_USEDEP}]
	>=dev-python/flask-cors-3.0.2[${PYTHON_USEDEP}]
	>=dev-python/pyparsing-2.2.0[${PYTHON_USEDEP}]
	>=dev-python/zxcvbn-python-4.4.15[${PYTHON_USEDEP}]
	>=dev-python/future-0.16.0[${PYTHON_USEDEP}]
	>=dev-python/APScheduler-3.3.1[${PYTHON_USEDEP}]
	>=dev-python/pathlib-1.0.1[${PYTHON_USEDEP}]
"
RDEPEND="${DEPEND}
	transmission? ( dev-python/transmissionrpc[${PYTHON_USEDEP}] )
"
DEPEND+=" test? ( dev-python/nose[${PYTHON_USEDEP}] )"

if [[ ${PV} == 9999 ]]; then
	DEPEND+=" dev-python/paver[${PYTHON_USEDEP}]"
else
	S="${WORKDIR}/${MY_P}"
fi

python_test() {
	cp -lr tests setup.cfg "${BUILD_DIR}" || die
	run_in_build_dir nosetests -v --attr=!online > "${T}/tests-${EPYTHON}.log" \
		|| die "Tests fail with ${EPYTHON}"
}
