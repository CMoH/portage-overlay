EAPI=8

inherit git-r3

DESCRIPTION="Erlang C++ Interface"
DESCRIPTION="The Erlang Language Server"
HOMEPAGE="https://erlang-ls.github.io"

EGIT_REPO_URI="https://github.com/erlang-ls/erlang_ls.git"
EGIT_COMMIT="${PV}"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64"
#IUSE="doc test"

RDEPEND=">=dev-lang/erlang-24"
BDEPEND="${RDEPEND}
	>=dev-lang/elixir-1.17
	dev-util/rebar:3"

#PATCHES="${FILESDIR}/rebar3_debug.patch"

#src_compile () {
#	#mix local.hex --force
#	# or alternatively
#	#mix archive.install github hexpm/hex branch latest
#	emake
#}

src_install () {
	emake PREFIX=${D}/usr install
}
