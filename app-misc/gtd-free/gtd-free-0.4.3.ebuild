# TODO: check java-pkg-2
# inherit java-pkg-2

#TODO: better URL and escription
DESCRIPTION="GTD-Free"
HOMEPAGE="http://TODO..."

BINARY="${P}.jar"
SRC_URI="mirror://sourceforge/${PN}/${BINARY}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND=">=virtual/jre-1.5.0"
	# amd64? ( app-emulation/emul-linux-x86-java )"
DEPEND="${RDEPEND}"

S=${WORKDIR}

# #TODO: remove this if fetch is enabled and works OK
# pkg_nofetch() {
# 	einfo "Please navigate your browser to"
# 	einfo "${DOWNLOAD_URL}"
# 	einfo "scroll down and notice the download button."
# 	einfo "Click the Download button for J2ME Wireless Toolkit 2.5.2"
# 	einfo "and download ${BINARY}"
# 	einfo "Put this file to ${DISTDIR} and resume the installation"
# }

src_unpack() {
	cp "${DISTDIR}/${BINARY}" "${S}"
}

src_install() {
	local DIR=/opt/gtd-free
	cd "${WORKDIR}"

	einfo "Copying files"
	insinto ${DIR}
	doins ${BINARY}
	doins "${FILESDIR}"/gtd-free.png

	insinto ${DIR}/bin
	doins "${FILESDIR}"/gtd-free "${D}"/${DIR}/bin

	insinto /usr/share/applications
	doins "${FILESDIR}"/gtd-free.desktop

	einfo "Setting permissions"
	chmod 755 "${D}"/${DIR}/bin/* || die
	chmod 644 "${D}"/${DIR}/*.jar || die

# TODO see if GTD has some docs to be installedinformation:
	# einfo "Installing documentation"
	# dohtml *.html
	# use doc && java-pkg_dohtml -r docs/*

	# cd ${D}/${DIR}/bin
	# java-pkg_jar-from sun-jaf activation.jar
	# java-pkg_jar-from sun-javamail mail.jar
	# java-pkg_jar-from xsdlib xsdlib.jar

	# einfo "Registering jar files"
	# # The zip files are somehow broken and python zip handling errors on them
	# JAVA_PKG_STRICT= java-pkg_regjar \
	# 	${D}${DIR}/lib/*.jar \
	# 	${D}${DIR}/wtklib/kenv.zip \
	# 	${D}${DIR}/wtklib/*.jar

	dodir /usr/bin
	dosym ${DIR}/bin/gtd-free /usr/bin/gtd-free
}
