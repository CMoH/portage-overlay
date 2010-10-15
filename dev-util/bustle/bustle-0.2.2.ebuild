EAPI=3

CABAL_FEATURES="bin"
inherit base haskell-cabal autotools flag-o-matic

DESCRIPTION="someone's favourite D-Bus profiler"
HOMEPAGE="http://willthompson.co.uk/bustle/"
SRC_URI="http://willthompson.co.uk/bustle/releases/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~arm ~x86 ~amd64"
IUSE=""

RDEPEND="
	sys-apps/dbus
	dev-lang/ghc
	dev-haskell/cairo
	dev-haskell/glade
	dev-haskell/glib
	>dev-haskell/gtk-0.11
	dev-haskell/pango"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

PATCHES=("${FILESDIR}/gentoo-${PV}.patch")

src_compile() {
	# seems to break linking to -ldbus-1
	filter-ldflags -Wl,--as-needed

	cd ${S}
	emake || die "compile failed"

	cabal_src_compile
}

src_install() {
	dobin bustle-dbus-monitor

	cabal_src_install
 }

