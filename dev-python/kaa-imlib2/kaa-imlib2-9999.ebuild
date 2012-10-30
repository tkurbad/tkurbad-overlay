# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"
PYTHON_DEPEND="2:2.5"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="2.4 3.* 2.7-pypy-* *-jython"

inherit distutils eutils

DESCRIPTION="Imlib2 wrapper for Python."
HOMEPAGE="http://freevo.sourceforge.net/kaa/"

if [[ ${PV} == "9999" ]] ; then
	inherit subversion
	ESVN_REPO_URI="svn://svn.freevo.org/kaa/trunk/imlib2"
	KEYWORDS=""
else
	SRC_URI="mirror://sourceforge/freevo/${P}.tar.gz"
	KEYWORDS="amd64 ppc x86"
fi

LICENSE="LGPL-2.1"
SLOT="0"
IUSE=""

DEPEND=">=dev-python/kaa-base-0.3.0
	dev-libs/libxml2[python]
	media-libs/imlib2"
RDEPEND="${DEPEND}"

PYTHON_MODNAME="kaa"
