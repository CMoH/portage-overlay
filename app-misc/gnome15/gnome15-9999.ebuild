EAPI="3"
SUPPORT_PYTHON_ABIS="1"

inherit bzr

DESCRIPTION="Gnome tools for the Logitech G Series Keyboards And Z-10 Speakers"
HOMEPAGE="http://www.tanktarta.pwp.blueyonder.co.uk/gnome15/index.html"

EBZR_REPO_URI="lp:gnome15"
# SRC_URI="http://www.tanktarta.pwp.blueyonder.co.uk/gnome15/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~alpha amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="cairo"

OPT_DEPEND="dev-python/setproctitle
		 dev-python/vobject
		 dev-python/pyalsa
cairo? ( x11-misc/cairo-clock )
"
RDEPEND="dev-python/pygtk
		 dev-python/dbus-python
		 dev-python/lxml
		 dev-python/pycairo
		 dev-python/imaging
		 dev-python/python-xlib
		 dev-python/librsvg-python
		 dev-python/pyalsaaudio
		 dev-python/feedparser
${OPT_DEPEND}"
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

