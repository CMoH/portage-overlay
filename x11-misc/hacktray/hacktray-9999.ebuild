EAPI=3

EGIT_REPO_URI="git://gitorious.org/hacktray/hacktray.git"

inherit git

DESCRIPTION="Simple application launcher for all kind of desktop sessions"
HOMEPAGE="http://kde-apps.org/content/show.php/HackTray?content=135572"

LICENSE="GPL"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=x11-libs/qt-core-4.6.3"
RDEPEND="${DEPEND}"

src_configure() {
	cd ${S} && qmake HackTray.pro
}

src_install() {
	# TODO: wouldn't it be better if we had an install target made by qmake?
	exeinto usr/bin
	doexe HackTray
}
