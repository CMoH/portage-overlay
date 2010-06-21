# TODO: examples and glibmm code. also tests

EAPI="2"

inherit eutils autotools

DESCRIPTION="D-Bus bindings for C++ from the dbus-cxx project"
HOMEPAGE="http://dbus-cxx.sourceforge.net/index.html"

MY_P="dbus-cxx-0.7.0"
MY_S=${WORKDIR}/${MY_P}

SRC_URI="http://downloads.sourceforge.net/project/dbus-cxx/dbus-cxx/0.7.0/${MY_P}.tar.gz"
# SRC_URI="mirrors://sourceforge/${PN}/${MY_P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"
IUSE="debug doc examples hal tools"

RDEPEND=">=sys-apps/dbus-1.1
	dev-util/pkgconfig
	dev-libs/libsigc++
	hal? ( sys-apps/hal )"

DEPEND="${RDEPEND}
	dev-libs/boost
	doc? ( app-doc/doxygen )"

src_unpack() {
	unpack ${A}
	cd "${MY_S}"
	epatch "${FILESDIR}/nonblock_on_no_reply.patch"
}

src_configure() {
# apparently even --disable-debug-output enables the debug output :)
	EXTRA_CONF=""
	if use debug; then
		EXTRA_CONF="--enable-debug-output"
	fi

#			$(use_enable examples) \

	cd ${MY_S} && econf \
		${EXTRA_CONF} \
		$(use_enable doc) \
		$(use_enable hal) \
		$(use_enable tools)
}

src_compile() {
	cd ${MY_S}
	emake || die "make failed"

	if use doc; then
		emake docs || die "make failed"
	fi
 }

# src_test() {
# 	cd "${TBD}"
# 	emake check || die "make check failed"
# }

src_install() {
	cd ${MY_S}
	emake DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS COPYING INSTALL NEWS README TODO
	if use doc; then
		dohtml -r doc/reference/html/*
	fi
}
