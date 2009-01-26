# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

MY_P=nauty22
DESCRIPTION="nauty is a program for computing automorphism groups of graphs and digraphs."
HOMEPAGE="http://cs.anu.edu.au/~bdm/nauty/"
SRC_URI="http://cs.anu.edu.au/~bdm/nauty/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND=""
RDEPEND=""

src_compile() {
	cd ${MY_P}
	econf || die "Configure failed"
	emake || die "Build failed"
}
