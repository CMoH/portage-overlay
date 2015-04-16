EAPI=5

inherit user

DESCRIPTION="Apache Archiva™: The Build Artifact Repository Manager"
HOMEPAGE="http://archiva.apache.org"
LICENSE="Apache-2.0"
SRC_URI="mirror://apache/archiva/2.2.0/binaries/apache-${P/-bin/}.tar.gz -> ${P}.tar.gz"
RESTRICT="mirror"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="media-fonts/dejavu
	media-libs/freetype
	>=dev-java/java-service-wrapper-3.2.3
	>=virtual/jre-1.7"

S="${WORKDIR}"

DEST_DIR=/opt/archiva
DATA_DIR=/var/lib/archiva

pkg_setup() {
	enewgroup archiva
	enewuser archiva -1 -1 ${DATA_DIR} archiva
}

src_install() {
	dodir /opt
	cp -R "${S}/apache-${P/-bin/}/" "${D}${DEST_DIR}" || die "Install failed!"

	# portage QA complains of non-linux libraries and of TEXTREL in provided linux ones
	# but we'll use dev-java/java-service-wrapper instead
	rm "${D}${DEST_DIR}"/{bin,lib}/*{linux,macosx,solaris,windows}*

	# create folders for mutable data
	keepdir /var/log/archiva "${DATA_DIR}" "${DATA_DIR}/conf" "${DATA_DIR}/data" "${DATA_DIR}/repositories" "${DATA_DIR}/temp"

	# keep package configuration files
	mv "${D}${DEST_DIR}/conf"/* "${D}${DATA_DIR}/conf"

	# remove mutable folders from /opt/archiva, and replace with symlinks
	rm -r "${D}${DEST_DIR}/conf" "${D}${DEST_DIR}/logs" "${D}${DEST_DIR}/temp"

	# logs go into /var/log
	dosym "${D}var/log/archiva" "${DEST_DIR}/logs"

	# data dirs go to /var/lib
	dosym "${D}${DATA_DIR}/conf" "${DEST_DIR}/conf"
	dosym "${D}${DATA_DIR}/data" "${DEST_DIR}/data"
	dosym "${D}${DATA_DIR}/repositories" "${DEST_DIR}/repositories"

	# for now keep the temp dir with the data in /var/lib/archiva
	# TODO: see if it would be better in /tmp
	dosym "${D}${DATA_DIR}/temp" "${DEST_DIR}/temp"

	# paths in archiva's config files are relative to java-service-wrapper's basedir
	dosym "${D}usr/bin/wrapper" "${DEST_DIR}/bin/wrapper"

#	insinto /etc/logrotate.d
#	newins "${FILESDIR}"/${PN}.logrotate ${PN/-bin/}

	newinitd "${FILESDIR}"/${PN}.init2 archiva
	newconfd "${FILESDIR}"/${PN}.confd archiva

	insinto "${DATA_DIR}/conf"
	newins "${FILESDIR}"/wrapper.conf wrapper.conf

	echo "CONFIG_PROTECT=\"${DATA_DIR}/conf\"" > "${T}/25${P}" || die
	doenvd "${T}/25${P}"

	fowners archiva:archiva \
			/var/log/archiva "${DATA_DIR}" "${DATA_DIR}/conf" "${DATA_DIR}/data" "${DATA_DIR}/repositories" "${DATA_DIR}/temp"
	fowners archiva:archiva "${DATA_DIR}/conf/archiva.xml"
}
