# Copyright 2026 Ciprian Ciubotariu
# Distributed under the terms of the GNU General Public License v2

EAPI=8

#PYTHON_COMPAT=( python3_{10..13} )
PYTHON_COMPAT=( python3_12 )
DISTUTILS_USE_PEP517=hatchling

inherit distutils-r1 pypi

DESCRIPTION="Automatic subtitle synchronization tool"
HOMEPAGE="https://pypi.org/project/assy/"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND="media-video/ffmpeg
		media-video/ffsubsync"
DEPEND="${RDEPEND}"
