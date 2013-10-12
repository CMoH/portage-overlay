EAPI=3

EGIT_REPO_URI="git://github.com/basho/rebar.git"

inherit git-2

DESCRIPTION="A sophisticated build-tool for Erlang projects that follows OTP principles."
HOMEPAGE="https://github.com/basho/rebar/"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND=">=dev-lang/erlang-15.2"
RDEPEND="${DEPEND}"

src_compile() {
    cd ${S} && ./bootstrap
}

src_install() {
    dobin rebar
}
