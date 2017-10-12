# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

MY_PN="pcb2gcodeGUI"
MY_P="${MY_PN}-${PV}"

inherit qmake-utils eutils

if [[ ${PV} == "9999" ]]; then
        EGIT_REPO_URI="https://github.com/pcb2gcode/pcb2gcodeGUI.git"
        inherit git-r3
else
        SRC_URI="https://github.com/pcb2gcode/pcb2gcodeGUI/archive/v${PV} -> ${MY_P}"
        KEYWORDS="~amd64 ~x86"
fi

DESCRIPTION="A GUI for pcb2gcode."
HOMEPAGE="https://github.com/pcb2gcode/pcb2gcodeGUI"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-qt/qtconcurrent:5
	dev-qt/qtcore:5
	dev-qt/qtgui:5
	dev-qt/qtwidgets:5
	dev-qt/qtsvg:5"
DEPEND="${RDEPEND}"

DOCS="LICENSE README.md"

src_configure() {
	eqmake5 PREFIX=/usr ${MY_PN}.pro
}

src_install() {
	INSTALL_ROOT="${D}" default
}
