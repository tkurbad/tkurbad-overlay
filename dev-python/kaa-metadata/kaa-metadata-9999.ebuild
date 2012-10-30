# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"
PYTHON_DEPEND="2:2.5"
PYTHON_USE_WITH="threads"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="2.4 3.* 2.7-pypy-* *-jython"

inherit distutils

DESCRIPTION="Powerful media metadata parser for media files in Python, successor of MMPython"
HOMEPAGE="http://freevo.sourceforge.net/kaa/"

if [[ ${PV} == "9999" ]] ; then
	inherit subversion
	ESVN_REPO_URI="svn://svn.freevo.org/kaa/trunk/metadata"
else
	SRC_URI="mirror://sourceforge/freevo/${P}.tar.gz"
	KEYWORDS="amd64 ppc x86"
fi

LICENSE="GPL-2"
SLOT="0"
IUSE="css dvd"

DEPEND=">=dev-python/kaa-base-0.3.0
	css? ( media-libs/libdvdcss )
	dvd? ( media-libs/libdvdread )"
RDEPEND="${DEPEND}"

PYTHON_MODNAME="kaa"

src_prepare() {
	distutils_src_prepare

	# Disable experimental exiv2 parser which fails to build.
	sed -e "s/-lexiv2/&_nonexistent/" -i setup.py || die "sed setup.py failed"
}
