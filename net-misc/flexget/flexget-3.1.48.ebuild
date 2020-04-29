# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

PYTHON_COMPAT=( python{2_7,3_6,3_7,3_8} pypy{,3} )

inherit distutils-r1 eutils systemd user

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
IUSE="systemd test transmission"

RESTRICT="nomirror"

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]
	~dev-python/aniso8601-4.0.1[${PYTHON_USEDEP}]
	=dev-python/APScheduler-3.5.3[${PYTHON_USEDEP}]
	~dev-python/babelfish-0.5.5[${PYTHON_USEDEP}]
	=dev-python/beautifulsoup-4.8.2:4[${PYTHON_USEDEP}]
	=dev-python/certifi-2020.4.5.1[${PYTHON_USEDEP}]
	~dev-python/chardet-3.0.4[${PYTHON_USEDEP}]
	~dev-python/cheroot-8.2.1[${PYTHON_USEDEP}]
	~dev-python/cherrypy-18.5.0[${PYTHON_USEDEP}]
	~dev-python/click-7.0[${PYTHON_USEDEP}]
	~dev-python/colorclass-2.2.0[${PYTHON_USEDEP}]
	~dev-python/feedparser-5.2.1[${PYTHON_USEDEP}]
	~dev-python/flask-1.1.2[${PYTHON_USEDEP}]
	=dev-python/flask-compress-1.4.0[${PYTHON_USEDEP}]
	=dev-python/flask-cors-3.0.2[${PYTHON_USEDEP}]
	~dev-python/flask-login-0.4.1[${PYTHON_USEDEP}]
	=dev-python/flask-restful-0.3.7[${PYTHON_USEDEP}]
	=dev-python/flask-restplus-0.10.1[${PYTHON_USEDEP}]
	=dev-python/guessit-3.1.0[${PYTHON_USEDEP}]
	=dev-python/html5lib-1.0.1[${PYTHON_USEDEP}]
	~dev-python/idna-2.9[${PYTHON_USEDEP}]
	~dev-python/itsdangerous-1.1.0[${PYTHON_USEDEP}]
	~dev-python/jaraco-functools-3.0.0[${PYTHON_USEDEP}]
	~dev-python/jinja-2.11.1[${PYTHON_USEDEP}]
	~dev-python/jsonschema-2.6.0[${PYTHON_USEDEP}]
	~dev-python/loguru-0.4.1[${PYTHON_USEDEP}]
	~dev-python/markupsafe-1.1.1[${PYTHON_USEDEP}]
	~dev-python/more-itertools-7.0.0[${PYTHON_USEDEP}]
	~dev-python/pillow-7.1.1[${PYTHON_USEDEP}]
	=dev-python/plumbum-1.6.4[${PYTHON_USEDEP}]
	~dev-python/portend-2.6[${PYTHON_USEDEP}]
	~dev-python/progressbar-2.5[${PYTHON_USEDEP}]
	~dev-python/pynzb-0.1.0[${PYTHON_USEDEP}]
	~dev-python/pyparsing-2.4.7[${PYTHON_USEDEP}]
	=dev-python/PyRSS2Gen-1.1[${PYTHON_USEDEP}]
	~dev-python/pystray-0.15.0[${PYTHON_USEDEP}]
	~dev-python/python-dateutil-2.8.1[${PYTHON_USEDEP}]
	=dev-python/pytz-2019.3[${PYTHON_USEDEP}]
	=dev-python/pyyaml-5.1.2[${PYTHON_USEDEP}]
	=dev-python/rebulk-2.0.0[${PYTHON_USEDEP}]
	~dev-python/requests-2.23.0[${PYTHON_USEDEP}]
	=dev-python/rpyc-4.0.2[${PYTHON_USEDEP}]
	=dev-python/six-1.14.0[${PYTHON_USEDEP}]
	=dev-python/soupsieve-1.9.5[${PYTHON_USEDEP}]
	=dev-python/sqlalchemy-1.3.11[${PYTHON_USEDEP}]
	~dev-python/tempora-1.14.1[${PYTHON_USEDEP}]
	=dev-python/terminaltables-3.1.0[${PYTHON_USEDEP}]
	=dev-python/tzlocal-1.4[${PYTHON_USEDEP}]
	=dev-python/urllib3-1.25.8[${PYTHON_USEDEP}]
	~dev-python/webencodings-0.5.1[${PYTHON_USEDEP}]
	~dev-python/werkzeug-0.16.1[${PYTHON_USEDEP}]
	=dev-python/zc-lockfile-2.0[${PYTHON_USEDEP}]
	=dev-python/zxcvbn-python-4.4.15[${PYTHON_USEDEP}]
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

pkg_setup() {
	enewgroup ${PN}
	enewuser ${PN} -1 -1 ${PN}
}

src_prepare() {
	distutils-r1_src_prepare

	sed -i -e "s/^aniso8601==1.2.1/aniso8601==4.0.1/" ${S}/requirements.txt || die
	sed -i -e "s/^apscheduler==3.5.0/apscheduler==3.5.3/" ${S}/requirements.txt || die
	#sed -i -e "s/^beautifulsoup4==4.6.2/beautifulsoup4==4.6.3/" ${S}/requirements.txt || die
	sed -i -e "s/^certifi==2017.4.17/certifi==2020.4.5.1/" ${S}/requirements.txt || die
	sed -i -e "s/^chardet==3.0.3/chardet==3.0.4/" ${S}/requirements.txt || die
	#sed -i -e "s/^cheroot==5.5.0/cheroot==6.0.0/" ${S}/requirements.txt || die
	sed -i -e "s/^cherrypy==18.4.0/cherrypy==18.5.0/" ${S}/requirements.txt || die
	sed -i -e "s/^click==6.7/click==7.0/" ${S}/requirements.txt || die
	sed -i -e "s/^flask==1.0.2/flask==1.1.2/" ${S}/requirements.txt || die
	sed -i -e "s/^flask-login==0.4.0/flask-login==0.4.1/" ${S}/requirements.txt || die
	sed -i -e "s/^flask-restful==0.3.6/flask-restful==0.3.7/" ${S}/requirements.txt || die
	#sed -i -e "s/^future==0.16.0/future==0.17.1/" ${S}/requirements.txt || die
	sed -i -e "s/^html5lib==0.999999999/html5lib==1.0.1/" ${S}/requirements.txt || die
	sed -i -e "s/^idna==2.8/idna==2.9/" ${S}/requirements.txt || die
	#sed -i -e "s/^importlib-metadata==0.8/importlib-metadata==0.23/" ${S}/requirements.txt || die
	sed -i -e "s/^itsdangerous==0.24/itsdangerous==1.1.0/" ${S}/requirements.txt || die
	sed -i -e "s/jaraco.functools==2.0/jaraco.functools==3.0/" ${S}/requirements.txt || die
	sed -i -e "s/^jinja2==2.10.1/jinja2==2.11.1/" ${S}/requirements.txt || die
	sed -i -e "s/^markupsafe==1.0/markupsafe==1.1.1/" ${S}/requirements.txt || die
	sed -i -e "s/^more-itertools==7.2.0/more-itertools==7.0.0/" ${S}/requirements.txt || die
	sed -i -e "s/^path.py==11.5.0/path.py==11.0.1/" ${S}/requirements.txt || die
	sed -i -e "s/^pillow==7.0.0/pillow==7.1.1/" ${S}/requirements.txt || die
	sed -i -e "s/^plumbum==1.6.3/plumbum==1.6.4/" ${S}/requirements.txt || die
	sed -i -e "s/^portend==1.8/portend==2.2/" ${S}/requirements.txt || die
	#sed -i -e "s/^progressbar==2.5/progressbar==2.3/" ${S}/requirements.txt || die
	sed -i -e "s/^python-dateutil==2.6.1/python-dateutil==2.8.1/" ${S}/requirements.txt || die
	sed -i -e "s/^pytz==2017.2/pytz==2019.3/" ${S}/requirements.txt || die
	sed -i -e "s/^pyparsing==2.2.0/pyparsing==2.4.7/" ${S}/requirements.txt || die
	sed -i -e "s/^requests==2.21.0/requests==2.23.0/" ${S}/requirements.txt || die
	sed -i -e "s/^rpyc==4.0.1/rpyc==4.0.2/" ${S}/requirements.txt || die
	sed -i -e "s/^six==1.13.0/six==1.14.0/" ${S}/requirements.txt || die
	#sed -i -e "s/^sqlalchemy==1.3.3/sqlalchemy==1.3.4/" ${S}/requirements.txt || die
	sed -i -e "s/^tempora==1.8/tempora==1.14.1/" ${S}/requirements.txt || die
	sed -i -e "s/^urllib3==1.24.2/urllib3==1.25.8/" ${S}/requirements.txt || die
	sed -i -e "s/^werkzeug==0.15.6/werkzeug==0.16.1/" ${S}/requirements.txt || die
	#sed -i -e "s/^zipp==0.3.3/zipp==0.6.0/" ${S}/requirements.txt || die
}

src_install() {
	distutils-r1_src_install

	keepdir /var/log/${PN}
	fowners ${PN}:${PN} /var/log/${PN}
        fperms 755 /var/log/${PN}

	if use systemd; then
		systemd_dounit "${FILESDIR}"/flexget.service
	fi
}

