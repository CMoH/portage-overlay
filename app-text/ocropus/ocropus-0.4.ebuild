inherit eutils

DESCRIPTION="The OCRopus(tm) open source document analysis and OCR system"
HOMEPAGE="http://code.google.com/p/ocropus/"
SRC_URI="http://ocropus.googlecode.com/files/${P}.tar.gz"
LICENSE="Apache-2.0"

SLOT="0"
KEYWORDS="~amd64"
IUSE="png jpeg tiff gif sdl blas openmp"

DEPEND="dev-util/scons"
RDEPEND="${DEPEND}
	  media-gfx/imagemagick
	  app-text/tesseract
	  >=media-libs/iulib-0.4
	  media-libs/leptonlib
	  sci-libs/gsl
	  dev-lang/python
	  dev-lang/swig
  png? ( media-libs/libpng )
 jpeg? ( media-libs/jpeg )
 tiff? ( media-libs/tiff )
  gif? ( media-libs/giflib )
  sdl? ( media-libs/sdl-gfx
		 media-libs/sdl-image
		 media-libs/libsdl )
 blas? ( virtual/blas )"

#      avcodec
#      avdevice
#      avformat
#      avutil
#      avfilter

src_unpack() {
	unpack ${A}
	cd ${S} && {
		epatch ${FILESDIR}/gentoo-location-${PV}.patch
		epatch ${FILESDIR}/ocropus-leptonica-${PV}.patch
		epatch ${FILESDIR}/genAM.py.patch
	}
}

src_compile() {
	cd ${S}/ocropus && {
		python genAM.py > Makefile.am || die "Configure failed"
		autoreconf || die "Configure failed"
		econf  \
			leptheaders=/usr/include/liblept \
			--with-tesseract=/usr \
			--with-leptonica=/usr \
			--with-iulib=/usr \
			$(use_with sdl SDL) \
			$(use_with openmp OpenMP) \
			|| die "Configure failed"
# todo: --with-fst
# todo: aspell?
	}

	cd ${S}/ocropus && emake || die "Compile failed"
}

src_test() {
	cd ${S}/ocropus/utilities
	./test-compile || die "Tests failed to compile"
	./test-run || die "At least one test failed"
}

src_install() {
	cd ${S}/ocropus && emake DESTDIR=${D} install || die "Install failed"
	dodoc CHANGES README
	gunzip -f ${D}/usr/share/ocropus/models/default.fst.gz
	gunzip -f ${D}/usr/share/ocropus/models/ocr-dict-case.fst.gz
}
