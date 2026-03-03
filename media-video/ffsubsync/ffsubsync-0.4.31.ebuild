# Copyright 2026 Ciprian Ciubotariu
# Distributed under the terms of the GNU General Public License v2

EAPI=8

#PYTHON_COMPAT=( python3_{10..13} )
PYTHON_COMPAT=( python3_12 )
DISTUTILS_USE_PEP517=setuptools

inherit distutils-r1 pypi

DESCRIPTION="Automatically synchronize subtitles with video or audio"
HOMEPAGE="https://github.com/smacke/ffsubsync"
SRC_URI="https://github.com/smacke/ffsubsync/archive/refs/tags/${PV}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 ~x86"

RDEPEND="
	dev-python/ffmpeg-python[${PYTHON_USEDEP}]
	dev-python/numpy[${PYTHON_USEDEP}]
	dev-python/pysubs2[${PYTHON_USEDEP}]
	dev-python/scipy[${PYTHON_USEDEP}]
	>=dev-python/srt-3.0.0[${PYTHON_USEDEP}]
	dev-python/tqdm[${PYTHON_USEDEP}]
	dev-python/webrtcvad[${PYTHON_USEDEP}]
	media-video/ffmpeg
"
DEPEND="${RDEPEND}"

python_install_all() {
	distutils-r1_python_install_all
	dodoc README.md
}
