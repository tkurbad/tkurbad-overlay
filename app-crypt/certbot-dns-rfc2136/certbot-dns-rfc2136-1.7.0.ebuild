# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=(python3_{6,7})

if [[ ${PV} == 9999* ]]; then
	EGIT_REPO_URI="https://github.com/certbot/certbot.git"
	inherit git-r3
	S=${WORKDIR}/${P}/${PN}
else
	SRC_URI="https://github.com/${PN%-dns-rfc2136}/${PN%-dns-rfc2136}/archive/v${PV}.tar.gz -> ${PN%-dns-rfc2136}-${PV}.tar.gz"
	KEYWORDS="~amd64 ~arm64 ~x86"
	S=${WORKDIR}/${PN%-dns-rfc2136}-${PV}/${PN}
fi

inherit distutils-r1

DESCRIPTION="Apache plugin for certbot (Let's Encrypt Client)"
HOMEPAGE="https://github.com/certbot/certbot https://letsencrypt.org/"

LICENSE="Apache-2.0"
SLOT="0"
IUSE="test"

RDEPEND=">=app-crypt/acme-0.40.0[${PYTHON_USEDEP}]
	>=app-crypt/certbot-1.7.0[${PYTHON_USEDEP}]
	dev-python/dnspython[${PYTHON_USEDEP}]
	dev-python/mock[${PYTHON_USEDEP}]
	dev-python/python-augeas[${PYTHON_USEDEP}]
	dev-python/zope-component[${PYTHON_USEDEP}]
	dev-python/zope-interface[${PYTHON_USEDEP}]"
DEPEND="test? ( ${RDEPEND}
	dev-python/nose[${PYTHON_USEDEP}] )
	dev-python/setuptools[${PYTHON_USEDEP}]"

python_test() {
	nosetests || die
}
