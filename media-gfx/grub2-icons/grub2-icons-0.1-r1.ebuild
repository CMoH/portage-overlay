EAPI=4

inherit git-2

DESCRIPTION="Grub2 theme icons for various operating systems"
HOMEPAGE="https://github.com/CMoH/grub2-theme-gentoo"

EGIT_REPO_URI="git://github.com/CMoH/grub2-theme-gentoo.git"

if [[ ${PV} != 9999* ]] ; then
	EGIT_COMMIT="v${PV}"
fi

KEYWORDS="*"
LICENSE="GPL-3"   # unsure what to place here
SLOT="0"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

src_install() {
	dodir /boot/grub/themes/icons/ || die

	insinto /boot/grub/themes/icons/
	doins icons/*.png
}
