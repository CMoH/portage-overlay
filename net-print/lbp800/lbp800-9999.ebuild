inherit subversion

DESCRIPTION="CANON LBP-800 Linux driver"
HOMEPAGE="http://www.veneto.com/lbp800/lbp800.html"
SRC_URI=""
ESVN_REPO_URI="https://www.cheepee.homedns.org/svn/personal/trunk/lbp800"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE=""

RDEPEND="net-print/cups"
DEPEND="${RDEPEND}"

src_install() {
	dodoc COPYING README SPECS THANKS
	dobin bin/Release/lbp800 lbp800-print foo2lbp800-wrapper

	exeinto /usr/lib/cups/backend
	doexe bin/Release/parcapt

	insinto /usr/share/ppd/custom/
	doins ppd/Canon-LBP-800.ppd
}
