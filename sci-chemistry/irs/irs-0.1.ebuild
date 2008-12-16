
inherit eutils

DESCRIPTION="Investigated Receptor Space is a suite for QSAR studies."
SRC_URI="http://irs.cheepee.homedns.org/downloads/${P}.tar.gz"
HOMEPAGE="http://irs.cheepee.homedns.org"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="qt3 doc test"

RDEPEND="dev-libs/boost
	dev-libs/libosstuff
	sci-chemistry/openbabel
	sci-mathematics/gmm
	qt3? ( <x11-libs/qt-4 )
    test? ( >=dev-util/cppunit-1.8.0 )"
DEPEND="${RDEPEND}
	doc? ( app-doc/doxygen )"

src_compile() {
	econf \
		$(use_enable doc doxygen) \
	|| die "Configure failed!"

	emake

	if use doc; then
		emake docs
	fi
}

src_install() {
	emake DESTDIR="${D}" install || die "Install failed"
	dodoc README AUTHORS TODO ChangeLog
	if use doc; then
		dohtml -V -r doc/html
	fi
}

