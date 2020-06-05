# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="6"

inherit eutils cmake-utils flag-o-matic systemd

if [[ ${PV} == "9999" ]] ; then
	ESVN_REPO_URI="http://streamboard.tv/svn/oscam/trunk"
	#ESVN_REPO_URI="http://www.oscam.cc/svn/oscam-mirror/trunk"
	inherit subversion
	#inherit git-r3
	#EGIT_REPO_URI="https://repo.or.cz/oscam.git"
	KEYWORDS=""
else
	SRC_URI=""
	KEYWORDS="~amd64 ~x86"
fi

DESCRIPTION="OSCam is an Open Source Conditional Access Module software"
HOMEPAGE="http://oscam.to/"
LICENSE="GPL-3"
SLOT="0"

IUSE="cacheex +debug doc ipv6 +ssl systemd"

IUSE_OSCAM_ADDONS="
	webif touch dvbapi clockfix irdeto_guess anticasc lb cyclecheck
	lcd led"
IUSE_OSCAM_CARDREADERS="
	phoenix internal mp35 sc8in1 smargo db2com stinger drecas
	pcsc smart"
IUSE_OSCAM_MODULES="
	monitor camd33 camd35 camd35_tcp newcamd cccam cccshare gbox
	radegast serial constcw pandora ghttp scam"
IUSE_OSCAM_READERS="
	nagra irdeto conax cryptoworks seca viaccess videoguard dre
	tongfang bulcrypt griffin dgcrypt"

for addon in ${IUSE_OSCAM_ADDONS}; do
	IUSE="${IUSE} oscam_addons_${addon}"
done
for cardreader in ${IUSE_OSCAM_CARDREADERS} ; do
	if [ "${cardreader}" == "smart" ] ; then
		IUSE="${IUSE} +oscam_cardreaders_${cardreader}"
	else
		IUSE="${IUSE} oscam_cardreaders_${cardreader}"
	fi
done
for module in ${IUSE_OSCAM_MODULES} ; do
	IUSE="${IUSE} oscam_modules_${module}"
done
for reader in ${IUSE_OSCAM_READERS} ; do
	IUSE="${IUSE} oscam_readers_${reader}"
done

DEPEND="oscam_cardreaders_pcsc? ( sys-apps/pcsc-lite )
	oscam_cardreaders_smart? ( >=dev-libs/libusb-1.0 )
	ssl? ( dev-libs/openssl )"

RDEPEND="${DEPEND}"

src_configure() {
	my_options=""

	# Generic options
	use cacheex && my_options="${my_options} CS_CACHEEX"
	use debug && my_options="${my_options} WITH_DEBUG"
	use ipv6 && my_options="${my_options} IPV6SUPPORT"
	use ssl && my_options="${my_options} WITH_SSL"

	# Addons
	use oscam_addons_webif && my_options="${my_options} WEBIF WEBIF_LIVELOG WEBIF_JQUERY"
	use oscam_addons_touch && my_options="${my_options} TOUCH"
	use oscam_addons_dvbapi && my_options="${my_options} HAVE_DVBAPI"
	use oscam_addons_clockfix && my_options="${my_options} CLOCKFIX"
	use oscam_addons_irdeto_guess && my_options="${my_options} IRDETO_GUESSING"
	use oscam_addons_anticasc && my_options="${my_options} CS_ANTICASC"
	use oscam_addons_lb && my_options="${my_options} WITH_LB"
	use oscam_addons_cyclecheck && my_options="${my_options} CW_CYCLE_CHECK"
	use oscam_addons_lcd && my_options="${my_options} LCDSUPPORT"
	use oscam_addons_led && my_options="${my_options} LEDSUPPORT"

	# Modules
	use oscam_modules_monitor && my_options="${my_options} MODULE_MONITOR"
	use oscam_modules_camd33 && my_options="${my_options} MODULE_CAMD33"
	use oscam_modules_camd35 && my_options="${my_options} MODULE_CAMD35"
	use oscam_modules_camd35_tcp && my_options="${my_options} MODULE_CAMD35_TCP"
	use oscam_modules_newcamd && my_options="${my_options} MODULE_NEWCAMD"
	use oscam_modules_cccam && my_options="${my_options} MODULE_CCCAM"
	use oscam_modules_cccshare && my_options="${my_options} MODULE_CCCSHARE"
	use oscam_modules_gbox && my_options="${my_options} MODULE_GBOX"
	use oscam_modules_radegast && my_options="${my_options} MODULE_RADEGAST"
	use oscam_modules_serial && my_options="${my_options} MODULE_SERIAL"
	use oscam_modules_constcw && my_options="${my_options} MODULE_CONSTCW"
	use oscam_modules_pandora && my_options="${my_options} MODULE_PANDORA"
	use oscam_modules_ghttp && my_options="${my_options} MODULE_GHTTP"
	use oscam_modules_scam && my_options="${my_options} MODULE_SCAM"

	# Cardreaders
	use oscam_cardreaders_phoenix && my_options="${my_options} CARDREADER_PHOENIX"
	use oscam_cardreaders_internal && my_options="${my_options} CARDREADER_INTERNAL"
	use oscam_cardreaders_mp35 && my_options="${my_options} CARDREADER_MP35"
	use oscam_cardreaders_sc8in1 && my_options="${my_options} CARDREADER_SC8IN1"
	use oscam_cardreaders_smargo && my_options="${my_options} CARDREADER_SMARGO"
	use oscam_cardreaders_db2com && my_options="${my_options} CARDREADER_DB2COM"
	use oscam_cardreaders_stinger && my_options="${my_options} CARDREADER_STINGER"
	use oscam_cardreaders_drecas && my_options="${my_options} CARDREADER_DRECAS"
	# Smart and PCSC are detected automatically
	use oscam_cardreaders_smart && my_options="${my_options}"
	use oscam_cardreaders_pcsc && my_options="${my_options}"

	# Readers
	use oscam_readers_nagra && my_options="${my_options} READER_NAGRA"
	use oscam_readers_irdeto && my_options="${my_options} READER_IRDETO"
	use oscam_readers_conax && my_options="${my_options} READER_CONAX"
	use oscam_readers_cryptoworks && my_options="${my_options} READER_CRYPTOWORKS"
	use oscam_readers_seca && my_options="${my_options} READER_SECA"
	use oscam_readers_viaccess && my_options="${my_options} READER_VIACCESS"
	use oscam_readers_videoguard && my_options="${my_options} READER_VIDEOGUARD"
	use oscam_readers_dre && my_options="${my_options} READER_DRE"
	use oscam_readers_tongfang && my_options="${my_options} READER_TONGFANG"
	use oscam_readers_bulcrypt && my_options="${my_options} READER_BULCRYPT"
	use oscam_readers_griffin && my_options="${my_options} READER_GRIFFIN"
	use oscam_readers_dgcrypt && my_options="${my_options} READER_DGCRYPT"

	"${S}"/config.sh --disable all --enable ${my_options}

	# Set default config dir to /etc/oscam
	MYCMAKEARGS="-DCS_CONFDIR=/etc/oscam"

	cmake-utils_src_configure
}

src_install() {
	# Binaries
	exeinto /usr/bin
	doexe "${CMAKE_BUILD_DIR}/oscam" "${CMAKE_BUILD_DIR}/utils/list_smargo"

	# Init scripts
	newinitd "${FILESDIR}/oscam.initd" oscam
	newconfd "${FILESDIR}/oscam.confd" oscam

	use systemd &&
		systemd_dounit "${FILESDIR}"/oscam.service

	# Create directory for logfiles
	dodir /var/log/oscam

	# Example configuration
	insinto /etc/oscam
	doins Distribution/doc/example/*

	# Manpages
	doman Distribution/doc/man/*
	# 'Repair' oscam.ac.5 manpage
	cp -a ${D}/usr/share/man/ac/man5/oscam.5 \
		${D}/usr/share/man/man5/oscam.ac.5
	rm -rf ${D}/usr/share/man/ac/

	# Documentation files
	dodoc README README.build README.config

	# HTML documentation
	if use doc ; then
		dohtml -r Distribution/doc/html/*
	fi

	# Monitor examples
	docinto monitor
	dodoc Distribution/monitor/*
}
