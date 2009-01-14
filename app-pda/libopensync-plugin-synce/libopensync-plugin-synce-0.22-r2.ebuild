# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-pda/libopensync-plugin-synce/libopensync-plugin-synce-0.20.ebuild,v 1.1 2006/11/10 18:57:04 peper Exp $

inherit autotools

DESCRIPTION="OpenSync Synce Plugin"
HOMEPAGE="http://www.opensync.org/"
SRC_URI="http://www.opensync.org/download/releases/0.22/${P}.tar.bz2"

KEYWORDS="~amd64 ~x86"
SLOT="0"
LICENSE="LGPL-2.1"
IUSE=""

DEPEND="=app-pda/libopensync-${PV}*
	app-pda/synce-librra
	dev-libs/libmimedir"

RDEPEND="${DEPEND}"

src_unpack() {
	unpack ${A}
	cd "${S}"
	
	#patch wall werror
	epatch "${FILESDIR}/${P}-warning.patch"
	epatch "${FILESDIR}/${P}-broken-pipe.patch"
	eautoreconf
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog COPYING NEWS README
}
