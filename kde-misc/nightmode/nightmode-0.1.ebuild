EAPI=2

inherit kde4-base

DESCRIPTION="Nightmode is a kwin plugin that makes the entire screen darker."
HOMEPAGE="http://kde-apps.org/content/show.php/Nightmode?content=123805"
SRC_URI="http://www.sharpley.org.uk/pages/software/nightmode/nightmode_0.1.tar.gz"

LICENSE="GPL-2"
SLOT="4"
KEYWORDS="~amd64 ~x86"
IUSE=""

#DOCS="AUTHORS README TODO"

src_unpack() {
	unpack ${A}
	mv ${WORKDIR}/nightmode ${WORKDIR}/nightmode-0.1
}