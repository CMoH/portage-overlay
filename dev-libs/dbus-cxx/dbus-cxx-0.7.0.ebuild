# TODO: examples and glibmm code. also tests

EAPI="2"

DESCRIPTION="D-Bus bindings for C++ from the dbus-cxx project"
HOMEPAGE="http://dbus-cxx.sourceforge.net/index.html"

SRC_URI="http://downloads.sourceforge.net/project/dbus-cxx/dbus-cxx/0.7.0/dbus-cxx-0.7.0.tar.gz"
# SRC_URI="mirrors://sourceforge/${PN}/${P}.tar.gz"

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

src_configure() {

# apparently even --disable-debug-output enables the debug output :)
	EXTRA_CONF=""
	if use debug; then
		EXTRA_CONF="--enable-debug-output"
	fi

#			$(use_enable examples) \

	econf \
		$(EXTRA_CONF) \
		$(use_enable doc) \
		$(use_enable hal) \
		$(use_enable tools)
}

src_compile() {
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
	emake DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS COPYING INSTALL NEWS README TODO
	if use doc; then
		dohtml -r doc/reference/html/*
	fi
}
