# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"

inherit subversion

DESCRIPTION="Platform Independent Tool to Download Files from One-Click-Hosting Sites"
HOMEPAGE="http://jdownloader.org"

ESVN_REPO_URI="svn://svn.jdownloader.org/jdownloader
	svn://svn.appwork.org/utils
	svn://svn.appwork.org/updclient
	svn://svn.jdownloader.org/jdownloader/browser"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND=">=virtual/jre-1.5"
