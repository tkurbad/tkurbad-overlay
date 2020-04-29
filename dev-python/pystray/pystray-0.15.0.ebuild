# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=7

PYTHON_COMPAT=( python3_{6,7,8} pypy )

inherit distutils-r1

MY_P="path.py-${PV}"

DESCRIPTION="Python library to create a system tray icon"
HOMEPAGE="https://pythonhosted.org/pystray/"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

SLOT="0"
LICENSE="MIT"
KEYWORDS="alpha amd64 arm ~arm64 hppa ia64 ~m68k ~mips ppc ppc64 ~s390 ~sh sparc x86 ~amd64-linux ~x86-linux"
IUSE=""


RDEPEND="
	dev-python/pillow
	>=dev-python/python-xlib-0.17
	dev-python/six
"

DEPEND="
	${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]
	>=dev-python/sphinx-1.3.1
"
