EAPI="2"

inherit multilib

MY_P=stantum-0.5.29-mdk10.1

DESCRIPTION="Stantum SDK CD_0.5.29_MDK10.1"
HOMEPAGE="http://www.stantum.com"
SRC_URI="http://www.cheepee.homedns.org/~cipi/portage/distfiles/${MY_P}.tar.bz2"

LICENSE="Stantum"
SLOT="0"
KEYWORDS="x86 amd64"
IUSE="X doc examples multilib"

# TODO: fix deps for X & opengl on x86 branch
DEPEND="virtual/libusb:0
	amd64? (
		app-emulation/emul-linux-x86-baselibs
		examples? ( X? (
		   app-emulation/emul-linux-x86-xlibs[opengl]
		) )
	)
	x86? (
		examples? ( X? ( virtual/opengl ) )
	)"
RDEPEND="${DEPEND}"

QA_TEXTRELS="usr/lib32/libSMT.so"

src_install() {
	cd ${MY_P}

	use amd64 && multilib_toolchain_setup x86

	insinto /usr/include
	doins    libSMT/include/SMT.h

	dolib.so libSMT/bin/linux/libSMT.so

	if use doc ; then
		dodoc Documentation/Manual.pdf
		dohtml -r Documentation/Reference
	fi

	if use examples ; then
		dobin libSMT/bin/linux/HelloCursors
		use X && dobin libSMT/bin/linux/Circles

	fi
}
