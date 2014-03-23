# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit autotools git-r3 eutils

DESCRIPTION="Erlang C++ Interface"
HOMEPAGE="https://github.com/saleyn/eixx.git"

EGIT_REPO_URI="https://github.com/saleyn/eixx.git"
EGIT_COMMIT="v1.1"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

RDEPEND=">=dev-libs/boost-1.49.0[threads]
	dev-lang/erlang"
DEPEND="${RDEPEND}
	sys-devel/autoconf-archive"

src_prepare() {
	epatch "${FILESDIR}/${PV}/0001-Fix-compile-errors.patch"
	epatch "${FILESDIR}/${PV}/0001-Compile-test-programs-using-check_PROGRAMS.patch"
	epatch "${FILESDIR}/${PV}/0001-Don-t-install-LICENSE-and-README-to-usr.patch"
}

src_configure() {
	cd "${S}" && ./bootstrap
	econf
}
