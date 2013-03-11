# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit toolchain-funcs git-2

DESCRIPTION="fastboot is a util to control android bootloader"
HOMEPAGE="android.googlesource.com"

EGIT_ANDROID="http://android.googlesource.com/platform"
EGIT_BRANCH="jb-mr1.1-release"
EGIT_REPO_URI=""$EGIT_ANDROID"/system/core"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="sys-libs/e2fsprogs-libs
	sys-libs/zlib"
RDEPEND="${DEPEND}"

src_compile(){
	cd fastboot
	git clone "$EGIT_ANDROID"/system/extras
	git clone "$EGIT_ANDROID"/external/libselinux
	cp ${FILESDIR}/Makefile Makefile	
	LIBS="-lext2fs" emake
}

src_install(){
	cd fastboot
	einstall DESTDIR=${D}
}
