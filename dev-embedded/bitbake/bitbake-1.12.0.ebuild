# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-embedded/bitbake/bitbake-9999.ebuild,v 1.6 2010/06/23 05:16:59 vapier Exp $

EAPI="2"
inherit distutils

if [[ ${PV} == "9999" ]] ; then
	EGIT_REPO_URI="git://git.openembedded.org/bitbake.git"
	inherit git
	SRC_URI=""
	KEYWORDS="~amd64 ~x86"
else
	SRC_URI="mirror://berlios/${PN}/${P}.tar.gz"
	KEYWORDS="~amd64 ~ppc ~x86"
fi

DESCRIPTION="package management tool for OpenEmbedded"
HOMEPAGE="http://developer.berlios.de/projects/bitbake/"

LICENSE="GPL-2"
SLOT="0"
IUSE=""

DEPEND="
	>=dev-lang/python-2.6[sqlite]
	>=dev-python/pysqlite-2.3.2
	dev-python/ply
	dev-python/progressbar"
