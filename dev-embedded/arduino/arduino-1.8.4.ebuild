# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5
JAVA_PKG_IUSE="doc +examples"

inherit eutils java-pkg-2 java-ant-2

DESCRIPTION="An open-source AVR electronics prototyping platform"
HOMEPAGE="http://arduino.cc/ https://github.com/arduino/Arduino"
SRC_URI="https://github.com/arduino/Arduino/archive/${PV}.tar.gz -> ${P}.tar.gz
mirror://gentoo/arduino-icons.tar.bz2"
LICENSE="GPL-2 GPL-2+ LGPL-2 CC-BY-SA-3.0"
SLOT="0"
KEYWORDS="amd64 x86"
RESTRICT="strip binchecks"
IUSE=""

COMMONDEP="
dev-embedded/listserialportsc
dev-java/jna:0
>dev-java/rxtx-2.1:2
dev-util/astyle"

RDEPEND="${COMMONDEP}
dev-embedded/avrdude
dev-embedded/uisp
sys-devel/crossdev
>=virtual/jre-1.8"

DEPEND="${COMMONDEP}
>=virtual/jdk-1.8"

EANT_GENTOO_CLASSPATH="jna,rxtx-2"
EANT_EXTRA_ARGS="-Dversion=${PV}"
EANT_BUILD_TARGET="build"
JAVA_ANT_REWRITE_CLASSPATH="yes"

src_unpack() {
	unpack ${A}
	# cd ../"${S}"
	mv Arduino-${PV} arduino-${PV}

}

java_prepare() {
	# Remove the libraries to ensure the system
	# libraries are used
	# rm app/lib/* || die
	rm -rf app/src/processing/app/macosx || die
	# Patch build/build.xml - remove local jar files
	# for rxtx and ecj (use system wide versions)
#	epatch "${FILESDIR}"/${P}-build.xml.patch

	# Patch launcher script to include rxtx class/ld paths
#	epatch "${FILESDIR}"/${P}-script.patch

	# Some OS X ThinkDifferent stuff from processing library
	epatch "${FILESDIR}"/${P}-Do-Not-ThinkDifferent.patch

	# Patch platform.txt for compiler paths
#	epatch "${FILESDIR}"/${P}-platform.patch
}

src_compile() {
	eant -f arduino-core/build.xml
	EANT_GENTOO_CLASSPATH_EXTRA="../arduino-core/arduino-core.jar"
	eant -f app/build.xml
	eant "${EANT_EXTRA_ARGS}" -f build/build.xml
}

src_install() {
	cd "${S}"/build/linux/work || die
	# java-pkg_dojar lib/arduino-core.jar lib/pde.jar
	java-pkg_dojar lib/*.jar
	java-pkg_dolauncher ${PN} --pwd /usr/share/${PN} --main processing.app.Base

	# This doesn't seem to be optional, it just hangs when starting without
	# examples in correct place
	#if use examples; then
		#java-pkg_doexamples examples
		#docompress -x /usr/share/doc/${P}/examples/
	#fi

	if use doc; then
		dodoc revisions.txt "${S}"/readme.txt
		dohtml -r reference
		java-pkg_dojavadoc "${S}"/build/javadoc/everything
	fi

	insinto "/usr/share/${PN}/"
	doins -r examples hardware libraries
	fowners -R root:uucp "/usr/share/${PN}/hardware"

	exeinto "/usr/share/${PN}/"
	doexe arduino-builder

	insinto "/usr/share/${PN}/lib"
	doins -r lib/*.txt lib/theme lib/*.png lib/*.conf lib/*.key

	# For TeensyDuino
	dosym /usr/bin/arduino "/usr/share/${PN}/arduino"

	# use system avrdude
	# patching class files is too hard
	dosym /usr/bin/avrdude "/usr/share/${PN}/hardware/tools/avrdude"
	dodir "/usr/share/${PN}/hardware/tools/avr/etc/"
	dosym /etc/avrdude.conf "/usr/share/${PN}/hardware/tools/avr/etc/avrdude.conf"

	dosym /usr/$(get_libdir)/libastylej.so.3 "/usr/share/${PN}/lib/libastylej.so"
	dosym /usr/$(get_libdir)/liblistSerialsj.so "/usr/share/${PN}/lib/liblistSerialsj.so"
	dodir "/usr/share/${PN}/hardware/tools/avr/bin/"
	dosym /usr/bin/avr-g++ "/usr/share/${PN}/hardware/tools/avr/bin/avr-addr2line"
	dosym /usr/bin/avr-ar "/usr/share/${PN}/hardware/tools/avr/bin/avr-ar"
	dosym /usr/bin/avr-as "/usr/share/${PN}/hardware/tools/avr/bin/avr-as"
	dosym /usr/bin/avr-c++ "/usr/share/${PN}/hardware/tools/avr/bin/avr-c++"
	dosym /usr/bin/avr-c++filt "/usr/share/${PN}/hardware/tools/avr/bin/avr-c++filt"
	dosym /usr/bin/avr-g++ "/usr/share/${PN}/hardware/tools/avr/bin/avr-cpp"
	dosym /usr/bin/avrdude "/usr/share/${PN}/hardware/tools/avr/bin/avrdude"
	dosym /usr/bin/avr-elfedit "/usr/share/${PN}/hardware/tools/avr/bin/avr-elfedit"
	dosym /usr/bin/avr-g++ "/usr/share/${PN}/hardware/tools/avr/bin/avr-g++"
	dosym /usr/bin/avr-gcc "/usr/share/${PN}/hardware/tools/avr/bin/avr-gcc"
	dosym /usr/bin/avr-gcc-ar "/usr/share/${PN}/hardware/tools/avr/bin/avr-gcc-ar"
	dosym /usr/bin/avr-gcc-nm "/usr/share/${PN}/hardware/tools/avr/bin/avr-gcc-nm"
	dosym /usr/bin/avr-gcc-ranlib "/usr/share/${PN}/hardware/tools/avr/bin/avr-gcc-ranlib"
	dosym /usr/bin/avr-gcov "/usr/share/${PN}/hardware/tools/avr/bin/avr-gcov"
	dosym /usr/bin/avr-gdb "/usr/share/${PN}/hardware/tools/avr/bin/avr-gdb"
	dosym /usr/bin/avr-gprof "/usr/share/${PN}/hardware/tools/avr/bin/avr-gprof"
	dosym /usr/bin/avr-ld "/usr/share/${PN}/hardware/tools/avr/bin/avr-ld"
	dosym /usr/bin/avr-ld.bfd "/usr/share/${PN}/hardware/tools/avr/bin/avr-ld.bfd"
	dosym /usr/bin/avr-man "/usr/share/${PN}/hardware/tools/avr/bin/avr-man"
	dosym /usr/bin/avr-nm "/usr/share/${PN}/hardware/tools/avr/bin/avr-nm"
	dosym /usr/bin/avr-objcopy "/usr/share/${PN}/hardware/tools/avr/bin/avr-objcopy"
	dosym /usr/bin/avr-objdump "/usr/share/${PN}/hardware/tools/avr/bin/avr-objdump"
	dosym /usr/bin/avr-ranlib "/usr/share/${PN}/hardware/tools/avr/bin/avr-ranlib"
	dosym /usr/bin/avr-readelf "/usr/share/${PN}/hardware/tools/avr/bin/avr-readelf"
	dosym /usr/bin/avr-run "/usr/share/${PN}/hardware/tools/avr/bin/avr-run"
	dosym /usr/bin/avr-size "/usr/share/${PN}/hardware/tools/avr/bin/avr-size"
	dosym /usr/bin/avr-strings "/usr/share/${PN}/hardware/tools/avr/bin/avr-strings"
	dosym /usr/bin/avr-strip "/usr/share/${PN}/hardware/tools/avr/bin/avr-strip"
	dosym /usr/bin/ctags "/usr/share/${PN}/hardware/tools/avr/bin/ctags"
	dosym /usr/bin/libusb-config "/usr/share/${PN}/hardware/tools/avr/bin/libusb-config"

	if [ -x /usr/bin/avr-ld ]; then
		BU_VER=$( avr-ld --version | head -1 | sed -e 's/^.*(.*) //' )
		dosym /usr/lib/binutils/avr/${BU_VER}/ldscripts "/usr/avr/lib/ldscripts"
	fi

	# install menu and icons
	domenu "${FILESDIR}/${PN}.desktop"
	for sz in 16 24 32 48 128 256; do
		newicon -s $sz \
			"${WORKDIR}/${PN}-icons/debian_icons_${sz}x${sz}_apps_${PN}.png" \
			"${PN}.png"
	done

}

pkg_postinst() {
	if [ ! -x /usr/bin/avr-g++ ]; then
		ewarn "Install avr crosscompiler using:"
		ewarn "  USE=\"-openmp -hardened -sanitize -vtv\" \\"
		ewarn "    crossdev -s4 --ex-gdb -v -S --target avr"
		echo
		ewarn "Afterwards, create a symlink for ldscripts:"
		ewarn "  BU_VER=$( avr-ld --version | head -1 | sed -e 's/^.*(.*) //' ) \\"
		ewarn "    ln -s /usr/lib/binutils/avr/\$BU_VER/ldscripts /usr/avr/lib/ldscripts"
	fi
}
