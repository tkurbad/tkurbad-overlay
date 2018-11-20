# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit webapp

DESCRIPTION="A free smart meter implementation with focus on data privacy"
HOMEPAGE="http://volkszaehler.org/"

MY_PN="${PN}.org"
MY_P="${MY_PN}-${PV}"

if [[ ${PV} == "9999" ]]; then
        EGIT_REPO_URI="https://github.com/volkszaehler/${MY_PN}"
        inherit git-r3
        KEYWORDS=""
else
        SRC_URI="https://github.com/volkszaehler/${PN}/archive/${PV} -> ${MY_P}"
        KEYWORDS="~amd64 ~x86"
fi

LICENSE="GPL-3"

RDEPEND="virtual/httpd-php
	dev-lang/php[cli,xml]
	dev-php/composer
	dev-php/doctrine
	dev-php/jpgraph
	dev-php/pecl-apcu
	dev-php/psr-log
	|| ( dev-lang/php[apache2] dev-lang/php[fpm] )
	postgres? ( dev-lang/php[postgres] )
	mysql? ( || ( dev-lang/php[mysql] dev-lang/php[mysqli] ) )
	vzlogger? ( sci-electronics/vzlogger )"

need_httpd_cgi

IUSE="+mysql postgres +vzlogger"

src_compile() {
	default

	composer install --no-dev
	composer dumpautoload
}

src_install() {
	webapp_src_preinst

	local docs="LICENSE README.md bin/README.md misc/controller/README"
	dodoc ${docs}
	rm -rf ${docs}

	insinto "${MY_HTDOCSDIR}"
	doins -r .

	webapp_configfile "${MY_HTDOCSDIR}"/etc/volkszaehler.conf.template.php
	webapp_configfile "${MY_HTDOCSDIR}"/etc/middleware.json
	webapp_configfile "${MY_HTDOCSDIR}"/etc/dbcopy.json

	webapp_src_install
}

pkg_postinst() {
	webapp_pkg_postinst

	local PASSWORD=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 32 | head -n 1)

	echo
	einfo "If this is a first time install, you have to configure your"
	einfo "volkszaehler instance."
	echo
	einfo "For MySQL, you have to run:"
	echo
	echo "	mysql -uroot -p"
	echo "	CREATE USER 'volkszaehler'@'localhost' IDENTIFIED BY '$PASSWORD';"
	echo "	CREATE DATABASE IF NOT EXISTS \`volkszaehler\`;"
	echo "	GRANT select, update, insert ON volkszaehler.* TO volkszaehler@localhost;"
	echo "	FLUSH PRIVILEGES;"
	echo "	QUIT;"
	echo
	echo "	cp -a /var/www/localhost/htdocs/${PN}/etc/volkszaehler.conf.template.php \\"
	echo "	  /var/www/localhost/htdocs/${PN}/etc/volkszaehler.conf.php"
	echo "	sed \"s/\([[:space:]+]\)= 'vz';/\1= 'volkszaehler';/\" \\"
	echo "	  -i /var/www/localhost/htdocs/${PN}/etc/volkszaehler.conf.php";
	echo "	sed \"s/\([[:space:]+]\)= 'demo';/\1= '$PASSWORD';/\" \\"
	echo "	  -i /var/www/localhost/htdocs/${PN}/etc/volkszaehler.conf.php";
	echo
	echo "	cd /var/www/localhost/htdocs/${PN}"
	echo "	php bin/doctrine orm:schema-tool:create --dump-sql > misc/sql/database.sql"
	echo "	cat database.sql | mysql -uroot volkszaehler -p"
	echo
	einfo "Additionally, you need to configure your webserver."
	einfo "Consult https://wiki.volkszaehler.org/software/middleware/installation for details."
	echo
}
