# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"
PYTHON_DEPEND="2:2.5"
PYTHON_USE_WITH="threads(+)"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="2.4 3.* 2.7-pypy-* *-jython"

inherit eutils distutils git-2

DESCRIPTION="pylcd - Python bindings for lcdproc."
HOMEPAGE="https://github.com/agrover/pylcd"

EGIT_REPO_URI="git://github.com/agrover/pylcd.git"

LICENSE="GPL-2.0"
SLOT="0"
IUSE=""

KEYWORDS="~amd64 ~x86"

DEPEND=""
RDEPEND="${DEPEND}
	app-misc/lcdproc"

PYTHON_CFLAGS=("2.* + -fno-strict-aliasing")
