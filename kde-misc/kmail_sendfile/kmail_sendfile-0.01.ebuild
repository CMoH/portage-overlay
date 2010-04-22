DESCRIPTION="Simple Send as Attachment with Kmail 4.0"
HOMEPAGE="http://kde-apps.org/content/show.php?content=123121"
SRC_URI="http://www.cheepee.homedns.org/~cipi/portage/distfiles/kmail_sendfile-0.01.desktop"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 amd64"
IUSE=""

RDEPEND="kde-base/kmail"
DEPEND="${RDEPEND}"

src_unpack() {
	mkdir "${S}"
	cp "${DISTDIR}/${A}" "${S}"
}

src_install() {
	insinto /usr/share/kde4/services
	doins kmail_sendfile-0.01.desktop
}
