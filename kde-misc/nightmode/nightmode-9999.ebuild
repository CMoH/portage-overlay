# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/nightmode/nightmode-0.3.ebuild,v 1.3 2012/04/19 04:46:58 maekke Exp $

EAPI=4

KDE_MINIMAL="4.8"
inherit git-2 kde4-base

DESCRIPTION="kwin plugin that makes the entire screen darker"
HOMEPAGE="http://kde-apps.org/content/show.php/Nightmode?content=123805"

#EGIT_REPO_URI="git://anongit.kde.org/scratch/davidedmundson/nightmode"
EGIT_REPO_URI="file:///home/cipi/src/nightmode"


LICENSE="GPL-2"
SLOT="4"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND="$(add_kdebase_dep kwin)"
RDEPEND="${DEPEND}"

S=${WORKDIR}
