EAPI=5

inherit elisp

DESCRIPTION="Emacs mode for editing and previewing Windows INI files"
HOMEPAGE="http://aurelien.tisne.free.fr/emacs-pages/emacs/ini-mode.html"
SRC_URI="http://aurelien.tisne.free.fr/emacs-pages/emacs/ini-mode.el"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 amd64"

SITEFILE=50ini-mode-gentoo.el

src_unpack() {
	mkdir "${S}"
	cp "${DISTDIR}"/ini-mode.el "${S}"/
}

src_compile() {
	elisp-compile *.el
}

src_install() {
	elisp-install "${PN}" *.el *.elc
	elisp-site-file-install "${FILESDIR}/${SITEFILE}"
}
