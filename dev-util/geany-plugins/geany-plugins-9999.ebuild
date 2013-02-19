# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/geany-plugins/geany-plugins-1.22-r1.ebuild,v 1.4 2012/12/07 18:30:48 ago Exp $

EAPI=4

inherit waf-utils vala versionator git-2

DESCRIPTION="A collection of different plugins for Geany"
HOMEPAGE="http://plugins.geany.org/geany-plugins"
SRC_URI=""

EGIT_REPO_URI="git://github.com/geany/geany-plugins.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="debugger devhelp enchant gpg gtkspell lua multiterm nls soup webkit"

LINGUAS="be ca da de es fr gl ja pt pt_BR ru tr zh_CN"

RDEPEND=">=dev-util/geany-$(get_version_component_range 1-2)
	dev-libs/libxml2:2
	dev-libs/glib:2
	debugger? ( x11-libs/vte:0 )
	devhelp? (
		dev-util/devhelp
		gnome-base/gconf:2
		net-libs/webkit-gtk:2
		x11-libs/gtk+:2
		x11-libs/libwnck:1
		)
	enchant? ( app-text/enchant )
	gpg? ( app-crypt/gpgme )
	gtkspell? ( app-text/gtkspell:2 )
	lua? ( dev-lang/lua )
	multiterm? (
		$(vala_depend)
		x11-libs/gtk+:2
		>=x11-libs/vte-0.28:0
		)
	soup? ( net-libs/libsoup )
	webkit? (
		net-libs/webkit-gtk:2
		x11-libs/gtk+:2
		x11-libs/gdk-pixbuf:2
		)"
DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext )
	virtual/pkgconfig"

src_prepare() {
	use multiterm && vala_src_prepare
}
