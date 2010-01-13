# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"
inherit subversion

ESVN_REPO_URI="http://svn.mangler.org/mangler/trunk"
DESCRIPTION="Open source VOIP client capable of connecting to Ventrilo 3.x servers"
HOMEPAGE="http://www.mangler.org/"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""
IUSE="alsa pulseaudio"

RDEPEND="dev-cpp/gtkmm:2.4
	media-libs/speex
	media-sound/gsm
	pulseaudio? media-sound/pulseaudio"
DEPEND="${DEPEND}
	dev-util/pkgconfig"

src_unpack() {
	subversion_src_unpack
	cd ${S} && autoreconf
}

src_configure() {
	local myconf="$(use_enable alsa) $(use_enable pulseaudio)"
	econf ${myconf} || die "configure failed"
}

src_install() {
	emake DESTDIR="${D}" install || die
}
