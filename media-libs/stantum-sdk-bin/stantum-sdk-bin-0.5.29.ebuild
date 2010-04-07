MY_P=stantum-0.5.29-mdk10.1

DESCRIPTION="Stantum SDK CD_0.5.29_MDK10.1"
HOMEPAGE="http://www.stantum.com"
SRC_URI="http://pinky.cheepee.homedns.org/~cipi/${MY_P}.tar.bz2"

LICENSE="Stantum"
SLOT="0"
KEYWORDS="x86"
IUSE="doc"
# IUSE="doc examples"

DEPEND="virtual/libusb:0"
RDEPEND="${DEPEND}"

src_install() {
	cd ${MY_P}

	insinto /usr/include
	doins    libSMT/include/SMT.h

	dolib.so libSMT/bin/linux/libSMT.so
	dolib    libSMT/lib/libSMT.lib

	if use doc ; then
		dodoc Documentation/Manual.pdf
		dohtml Documentation/Reference
	fi

	# if use examples ; then
	# fi
}
