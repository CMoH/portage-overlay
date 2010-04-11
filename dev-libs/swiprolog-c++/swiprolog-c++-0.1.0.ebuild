# Distributed under the terms of the GNU General Public License v2

# TODO: add prolog lib and manual to Makefile, as well as install... maybe ;)

DESCRIPTION="SWI-Prolog C++ wrapper"
HOMEPAGE="http://www.volker-wysk.de/swiprolog-c++/"
SRC_URI="http://www.volker-wysk.de/swiprolog-c++/${PN}-${PV}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~amd64"
IUSE=""
DEPEND=">=dev-lang/swi-prolog-4.0.9
	dev-libs/libxslt"

# from the requirements; DocBook may be fuzzy
RDEPEND="${DEPEND}
	>=app-text/docbook-xsl-stylesheets-1.40
	>=app-text/docbook-xml-dtd-4.1.2"

src_compile() {
	make prolog-lib manual
	emake || die "build failed"
}
