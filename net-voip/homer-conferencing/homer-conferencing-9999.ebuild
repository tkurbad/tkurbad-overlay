# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit eutils multilib

DESCRIPTION="Homer Conferencing (short: Homer) is a free SIP softphone with advanced audio and video support."
HOMEPAGE="http://www.homer-conferencing.com"

MY_PN="Homer-Conferencing"
BINARY="Homer"

if [[ ${PV} == *9999* ]]; then
	inherit git-2
	EGIT_REPO_URI="git://github.com/${MY_PN}/${MY_PN}.git"
	KEYWORDS=""
else
	SRC_URI="https://github.com/${MY_PN}/${MY_PN}/archive/V${PV}.tar.gz -> ${PN}-${PV}.tar.gz"
	KEYWORDS="~x86 ~amd64"
fi

LICENSE="GPL-2"
SLOT="0"
IUSE=""

RDEPEND=">=dev-libs/openssl-1.0
	media-libs/alsa-lib
	>=media-libs/libsdl-1.2[X,audio,video,alsa]
	media-libs/portaudio[alsa]
	>=media-libs/sdl-mixer-1.2
	>=media-libs/sdl-sound-1.0
	media-libs/x264
	media-video/ffmpeg
	>=net-libs/sofia-sip-1.12
	>=x11-libs/qt-core-4.6:4
	>=x11-libs/qt-gui-4.6:4"
DEPEND="dev-util/cmake
	${RDEPEND}"

S="${WORKDIR}/${MY_PN}-${PV}"

src_compile() {
	emake -C HomerBuild all \
		INSTALL_PREFIX=/usr/bin \
		INSTALL_LIBDIR=/usr/$(get_libdir) \
		INSTALL_DATADIR=/usr/share/${PN} \
		|| die "make failed"
}

src_install() {
	emake -C HomerBuild install \
		DESTDIR="${D}" \
		|| die "make install failed"

	# Create .desktop entry
	newicon "${BINARY}"/"${BINARY}".png "${MY_PN}".png
	make_desktop_entry "${BINARY}" "${MY_PN}" "${MY_PN}" "Network;InstantMessaging;Telephony;VideoConference"
}
