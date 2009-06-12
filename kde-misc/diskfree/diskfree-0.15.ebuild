
inherit kde
need-kde 3.4

DESCRIPTION="Is an applet for the KDE Kicker to show how much free disk space is available on your mounted partitions."
HOMEPAGE="http://www.ricardis.tudelft.nl/~vincent/diskfree/"
SRC_URI="http://www.ricardis.tudelft.nl/~vincent/diskfree/download/${P}.tar.gz"

LICENSE="GPL"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

#src_compile() {
#	scons PREFIX=/usr DESTDIR=${D}
#}

src_install() {
	kde_src_install
	dodir ${KDEDIR}/share/apps/kicker/applets/
	dosym /usr/share/apps/kicker/applets/diskfree.desktop ${KDEDIR}/share/apps/kicker/applets/
}

