# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"

inherit eutils webapp depend.php

DESCRIPTION="Web interface for nzbget NNTP client < 0.9"
HOMEPAGE="http://nzbget.sourceforge.net/"
SRC_URI="mirror://sourceforge/nzbget/web-interface-stable/${P}.zip"
RESTRICT="nomirror"

LICENSE="GPL-2"
KEYWORDS="~amd64"
IUSE=""

RDEPEND="dev-lang/php[xml,xmlrpc]"

need_httpd_cgi
need_php_httpd

S="${WORKDIR}/${PN}"

pkg_setup() {
	webapp_pkg_setup
}

src_install() {
	webapp_src_preinst

	dodoc COPYING README ChangeLog || die
	rm -f COPYING README ChangeLog

	insinto "${MY_HTDOCSDIR}"
	doins -r .

	webapp_configfile "${MY_HTDOCSDIR}"/settings-template.php
	webapp_src_install
}
