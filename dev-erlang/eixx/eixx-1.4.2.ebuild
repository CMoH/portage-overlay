EAPI=7

inherit cmake-utils git-r3 eutils

DESCRIPTION="Erlang C++ Interface"
HOMEPAGE="http://dev.tm.cheepee.ro/projects/eixx https://github.com/saleyn/eixx.git"

EGIT_REPO_URI="http://dev.tm.cheepee.ro/eixx.git"
EGIT_COMMIT="v${PV}"
#EGIT_BRANCH="master"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64"
IUSE="doc test"

RDEPEND=">=dev-libs/boost-1.65.0[threads]
	>=dev-lang/erlang-21.1.1"
DEPEND="${RDEPEND}
	sys-devel/make
	doc? ( app-doc/doxygen )"

#PATCHES=( ${FILESDIR}/gentoo-build.patch )

src_prepare() {
	cmake-utils_src_prepare
	use test || cmake_comment_add_subdirectory "test"
}

src_configure() {
	local mycmakeargs=(
		-DENABLE_DOXYGEN="$(usex doc)"
		-DCMAKE_USER_MAKE_RULES_OVERRIDE=${S}/build-aux/CMakeInit.txt
		-DBOOST_INCLUDEDIR=${ESYSROOT}/usr/include
		-DBOOST_LIBRARYDIR=${ESYSROOT}/usr/lib64
	)
	cmake-utils_src_configure
}
