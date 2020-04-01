# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit bash-completion-r1 git-r3 udev eutils

DESCRIPTION="A free and open TL866XX programmer"
HOMEPAGE="https://gitlab.com/DavidGriffith/minipro"
EGIT_REPO_URI="https://gitlab.com/DavidGriffith/minipro.git"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""
IUSE=""

RDEPEND="virtual/libusb:1"
DEPEND="${RDEPEND}"

src_install() {
	dobin ${PN}{,hex}
	udev_dorules udev/60-${PN}.rules
	udev_dorules udev/61-${PN}-{plugdev,uaccess}.rules
	doman man/${PN}.1
	dobashcomp bash_completion.d/${PN}
}
