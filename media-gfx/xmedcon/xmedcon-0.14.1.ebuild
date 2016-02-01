# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# filename: xmedcon.ebuild.in                                             #
#                                                                         #
# UTILITY text: Medical Image Conversion Utility                          #
#                                                                         #
# purpose     : our Gentoo's portage ebuild template                      #
#                                                                         #
# project     : (X)MedCon by Erik Nolf                                    #
#                                                                         #
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# $Id: xmedcon.ebuild.in,v 1.12 2015/12/27 00:42:27 enlf Exp $
#

EAPI=5

DESCRIPTION="Medical Image Conversion Utility"
HOMEPAGE="http://${PN}.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="GPL-2 LGPL-2"
SLOT="0"
#KEYWORDS="alpha amd64 arm hppa ia64 mips ppc ppc64 sparc x86"
KEYWORDS="x86 ~amd64"
IUSE="png gtk"

DEPEND="=x11-libs/gtk+-2*
        png? ( >=media-libs/libpng-1.2.1 )
		dev-util/pkgconfig"

src_configure() {

	econf $(use_enable gtk gui) $(use_enable png)
}

src_compile() {

	emake
}

src_install() {

	emake DESTDIR="${D}" install

	dodoc AUTHORS COPYING* INSTALL NEWS README REMARKS
}
