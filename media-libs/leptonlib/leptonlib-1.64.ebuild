inherit eutils autotools

DESCRIPTION="Leptonica is a pedagogically-oriented open source site containing software that is broadly useful for image processing and image analysis applications."
HOMEPAGE="http://www.leptonica.com"
SRC_URI="http://www.leptonica.com/source/leptonlib-1.64.tar.gz"
LICENSE="CCLP-Attribution-2.5"

SLOT="0"
KEYWORDS="~amd64 ~arm"
IUSE="png jpeg tiff gif"

DEPEND="
  png? ( media-libs/libpng )
 jpeg? ( media-libs/jpeg )
 tiff? ( media-libs/tiff )
  gif? ( media-libs/giflib )"
RDEPEND="${DEPEND}"

src_unpack() {
	unpack "${A}"
	cd "${S}"
	epatch "${FILESDIR}/cross-${P}.patch"
	eautoreconf
}

# src_compile() {
# 	econf || die "Configure failed"
# 	emake || die "Build failed"
# }

src_install() {
	emake DESTDIR="${D}" install || die "Install failed"
}
