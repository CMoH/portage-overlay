DESCRIPTION="Portability library containing OS dependent stuff"
HOMEPAGE="http://irs.cheepee.homedns.org"
SRC_URI="http://irs.cheepee.homedns.org/downloads/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 amd64"
IUSE="doc test"

RDEPEND="dev-libs/boost
	test? ( >=dev-util/cppunit-1.8.0 )"
DEPEND="${RDEPEND}
	doc? ( app-doc/doxygen )"

src_install() {
	emake DESTDIR="${D}" install || die "Install failed"
}
