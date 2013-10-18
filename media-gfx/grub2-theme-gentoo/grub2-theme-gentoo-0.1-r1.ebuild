EAPI=4

inherit git-2

DESCRIPTION="Grub2 theme for Gentoo systems"
HOMEPAGE="https://github.com/CMoH/grub2-theme-gentoo"

EGIT_REPO_URI="git://github.com/CMoH/grub2-theme-gentoo.git"

if [[ ${PV} != 9999* ]] ; then
	EGIT_COMMIT="v${PV}"
fi

KEYWORDS="*"
LICENSE="GPL-3"
SLOT="0"
IUSE=""

DEPEND="=media-gfx/grub2-icons-${PVR}"
RDEPEND="${DEPEND}"

src_install() {
	dodir /boot/grub/themes/gentoo/ || die

	insinto /boot/grub/themes/gentoo/
	doins gentoo/*

	dosym /boot/grub/themes/icons /boot/grub/themes/gentoo/icons


	elog "To enable this grub2 theme you will need to edit /etc/default/grub"
	elog "and set: GRUB_THEME=/boot/grub/themes/gentoo/theme.txt"
	elog "Remember to enable Grub2 graphics mode and run grub2-mkconfig when finished"
	elog "See http://www.gentoo.org/doc/en/grub2-migration.xml for more information"
	elog "and perhaps http://wiki.gentoo.org/wiki/GRUB2"
}
