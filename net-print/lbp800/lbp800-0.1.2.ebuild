DESCRIPTION="Utility for configuring RFC 2684 ATM/Ethernet bridging"
HOMEPAGE="http://www.veneto.com/lbp800/lbp800.html"
SRC_URI="http://www.veneto.com/lbp800/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""

RDEPEND="net-print/cups"
DEPEND="${RDEPEND}"

src_install() {
	dodoc COPYING README SPECS THANKS
	dobin bin/Release/lbp800 lbp800-print foo2lbp800-wrapper

	insinto /usr/lib/cups/backend
	doins bin/Release/parcapt

	insinto /usr/share/ppd/custom/
	doins ppd/Canon-LBP-800.ppd
}
