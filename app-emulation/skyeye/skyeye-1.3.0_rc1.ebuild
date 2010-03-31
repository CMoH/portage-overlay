DESCRIPTION="an ARM embedded hardware simulator"
HOMEPAGE="http://www.skyeye.org/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="qt4"

RDEPEND="sys-libs/ncurses
	media-libs/freetype
	>=x11-libs/gtk+-2
	>=dev-libs/glib-2
	x11-libs/pango"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_compile() {
	# econf $(use_enable lcd)
	econf $(use_enable lcd)
	emake lib build_lib
	emake
	# if use qt4 ; then
	# 	cd ${S}/${P}/gui/qt4_src && make mocclean
	# 	emake skyeye_gui
	# fi
}

src_install() {
	# dobin binary/skyeye || die "skyeye"
	# if use qt4 ; then
	# 	dobin binary/skyeye-gui || die "skyeye-gui"
	# fi
	emake PREFIX="${D}" DESTDIR="${D}" install
	dodoc ChangeLog README
}
