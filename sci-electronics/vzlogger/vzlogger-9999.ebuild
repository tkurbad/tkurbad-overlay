# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit cmake-utils systemd

if [[ ${PV} == "9999" ]]; then
        EGIT_REPO_URI="https://github.com/volkszaehler/${PN}"
        inherit git-r3
	KEYWORDS=""
else
	SRC_URI=""
	KEYWORDS="~amd64 ~x86"
fi

DESCRIPTION="A tool to read and log measurements of a wide variety of smart meters and sensors to the volkszaehler.org middleware"
HOMEPAGE="https://github.com/volkszaehler/vzlogger"

LICENSE="GPL-3"
SLOT="0"
IUSE="+logrotate +microhttpd mqtt ocr oms +sml systemd"

RDEPEND="
	dev-libs/cyrus-sasl
	dev-libs/json-c
	dev-libs/libgcrypt
	net-libs/gnutls
	logrotate? ( app-admin/logrotate )
	microhttpd? ( >=net-libs/libmicrohttpd-0.9 )
	mqtt? ( app-misc/mosquitto )
	ocr? ( media-libs/leptonica app-text/tesseract )
	oms? ( sci-libs/libmbus )
	sml? ( sci-libs/libsml )
"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

src_prepare() {
	#epatch "${FILESDIR}"/"${P}"-curl_tls1_2.patch
	epatch "${FILESDIR}"/"${P}"-cpp-true_false.patch

	default

	cmake-utils_src_prepare

	sed -e "s/  share\/doc\/vzlogger-\${VZLOGGER_MAJOR_VERSION}-\${VZLOGGER_MINOR_VERSION}$/  share\/doc\/vzlogger-${PV}/" \
		-i ${S}/CMakeLists.txt \
	|| die "sed failed"
	sed -e "s:Wno-system-headers:Wno-system-headers -Wno-error -fpermissive:" \
		-i ${S}/modules/CompilerFlags.cmake \
	|| die "sed failed"

	#sed -e "s@ExecStart=/usr/local/bin/vzlogger@ExecStart=/usr/bin/vzlogger@" \
	#	-i ${S}/etc/vzlogger.service \
	#|| die "sed failed"
}

src_configure() {
	local mycmakeargs=(
		-DBUILD_TEST=off
		-DENABLE_LOCAL=$(usex microhttpd)
		-DENABLE_MQTT=$(usex mqtt)
		-DENABLE_OCR=$(usex ocr)
		-DENABLE_OCR_TESSERACT=$(usex ocr)
		-DENABLE_OMS=$(usex oms)
		-DENABLE_SML=$(usex sml)
		-DJSON_HOME=/usr
		-DMICROHTTPD_HOME=/usr
		-DSML_HOME=/usr
	)
	cmake-utils_src_configure
}

src_install() {
	cmake-utils_src_install

	insinto /etc
	doins ${S}/etc/vzlogger.conf

	if use logrotate; then
		insinto /etc/logrotate.d
		newins ${FILESDIR}/vzlogger.logrotate vzlogger
	fi

	use systemd && systemd_dounit ${FILESDIR}/vzlogger.service
}
