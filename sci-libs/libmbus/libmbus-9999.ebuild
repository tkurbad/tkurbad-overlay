# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

if [[ ${PV} == "9999" ]]; then
        EGIT_REPO_URI="https://github.com/rscada/${PN}"
        inherit autotools git-r3
	KEYWORDS=""
else
	SRC_URI="https://github.com/rscada/${PN}/archive/${PV} -> ${P}"
	KEYWORDS="~amd64 ~x86"
fi

DESCRIPTION="An open source library for the M-bus (Meter-Bus) protocol"
HOMEPAGE="https://github.com/rscada/libmbus"

LICENSE=""
SLOT="0"
IUSE=""

RDEPEND=""

DEPEND="${RDEPEND}
	virtual/pkgconfig"

src_prepare() {
	default
	eautoreconf
}
