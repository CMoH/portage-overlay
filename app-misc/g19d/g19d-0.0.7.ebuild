EAPI="3"
SUPPORT_PYTHON_ABIS="1"

DESCRIPTION="Gnome tools for the Logitech G Series Keyboards And Z-10 Speakers"
HOMEPAGE="http://www.tanktarta.pwp.blueyonder.co.uk/gnome15/index.html"
SRC_URI="http://www.tanktarta.pwp.blueyonder.co.uk/gnome15/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~alpha amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

RDEPEND="=app-misc/gnome15-0.4.1
		 dev-python/python-uinput"
DEPEND="${RDEPEND}"

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
}

pkg_postinst() {
	python_mod_optimize ${PN}
}

pkg_postrm() {
	python_mod_cleanup ${PN}
}

