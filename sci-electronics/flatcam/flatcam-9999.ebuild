# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6
PYTHON_COMPAT=( python2_7 )

inherit distutils-r1 git-r3

DESCRIPTION="Free and Open-source PCB CAM.."
HOMEPAGE="http://flatcam.org"
SRC_URI="https://bitbucket.org/jpcgt/flatcam/downloads/FlatCAM-8.5.zip"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND=""
DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]
	${RDEPEND}"
