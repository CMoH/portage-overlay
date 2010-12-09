EAPI="2"
inherit distutils

DESCRIPTION="package management tool for OpenEmbedded"
HOMEPAGE="http://developer.berlios.de/projects/bitbake/"
SRC_URI="http://download.berlios.de/bitbake/bitbake-${PV}.tar.gz"

KEYWORDS="~amd64 ~x86"

LICENSE="GPL-2"
SLOT="0"
IUSE=""

DEPEND="
	|| (
		>=dev-lang/python-2.5[sqlite]
		>=dev-python/pysqlite-2.3.2
	)"
