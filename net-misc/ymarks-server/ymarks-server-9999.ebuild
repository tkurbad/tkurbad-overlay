# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit eutils user systemd
if [[ ${PV} == "9999" ]] ; then
	EHG_REPO_URI="https://bitbucket.org/ymarks/${PN}"
	inherit mercurial
fi

DESCRIPTION="Simple KISS bookmark sync server"
HOMEPAGE="https://www.ymarks.org"

LICENSE="WTFPL"
SLOT="0"
IUSE="systemd"

RDEPEND="dev-db/sqlite:3"
DEPEND="${RDEPEND}"

pkg_setup() {
	enewgroup ymarks
        enewuser ymarks -1 /bin/bash /etc/ymarks ymarks
}

src_prepare() {
	default
	eapply "${FILESDIR}/ymarks-server-constants.patch"
}

src_compile() {
	cc -I . -I /usr/include -o ymarks 3rdparty/cJSON.c src/backup.c src/main.c -lsqlite3
}

src_install() {
	exeinto /etc/ymarks
	doexe ${S}/ymarks
	echo "12345" > "${D}"/etc/ymarks/PIN.txt
	fowners -R ymarks:ymarks /etc/ymarks

	use systemd &&
		systemd_dounit "${FILESDIR}"/ymarks.service
}
