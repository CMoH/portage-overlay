# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils java-utils-2

MY_PV="v2ur2"
MY_BUILDNR="b04"
MY_SRC_PREFIX="http://download.java.net/javaee5"
MY_SRC_DIR="promoted/Linux"
MY_JAR_PREFIX="glassfish-installer"
ML_JAR_SUFFIX="linux-ml.jar"
JAR_SUFFIX="linux.jar"

MY_URL="ml? ( ${MY_SRC_PREFIX}/${MY_PV}/${MY_SRC_DIR}/${MY_JAR_PREFIX}-${MY_PV}-${MY_BUILDNR}-${ML_JAR_SUFFIX} )
!ml? ( ${MY_SRC_PREFIX}/${MY_PV}/${MY_SRC_DIR}/${MY_JAR_PREFIX}-${MY_PV}-${MY_BUILDNR}-${JAR_SUFFIX} )"

DESCRIPTION="Glassfish Application Server"
HOMEPAGE="https://glassfish.dev.java.net/"
SRC_URI="${MY_URL}"
LICENSE="CDDL GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="cluster ml"
DEPEND=">=virtual/jdk-1.5"
RDEPEND="${DEPEND}"

GLASSFISH_INSTALL_BASE="/opt/glassfish"
GLASSFISH_WORKDIR="${WORKDIR}/glassfish"
GLASSFISH_ENVD_FILE="99glassfish"
GLASSFISH_GENTOO_README="${GLASSFISH_INSTALL_BASE}/README.gentoo"

stop_domains() {
	einfo ""
	einfo "Stopping any running Glassfish domains..."
	local domains=`$1/bin/asadmin list-domains | grep "running" | grep -v "not" | cut -f 1 -d" "`
	for domain in $domains; do
	  einfo "`$1/bin/asadmin stop-domain $domain`"
	done
	einfo "Glassfish domains stopped."
	einfo ""
}

pkg_setup() {
	java-pkg_init
	if has_version ${PN}; then
		einfo "Glassfish already installed..."
		local gfhome=`grep GLASSFISH_HOME /etc/env.d/${GLASSFISH_ENVD_FILE} | cut -f 2 -d"="`
		stop_domains "$gfhome"
		einfo "Reinstalling Glassfish..."
	fi
	enewgroup glassfish
	enewuser glassfish -1 -1 /dev/null glassfish
}

src_unpack() {
# unsetting the DISPLAY is required to stop the glassfish installer popping up a
# graphical license display.
	unset DISPLAY
	echo "a\n" | java -Xmx256m -jar ${DISTDIR}/${A}
}

src_install() {
	cd ${GLASSFISH_WORKDIR}
	chmod -R +x lib/ant/bin
	local setupfile
	if use cluster; then
		setupfile="setup-cluster.xml"
	else
		setupfile="setup.xml"
	fi

# The ant setup writes 2 files into the home directory of the installing user.
# Attempts to set HOME="..." failed, probably because of ant.
	addwrite /root/.asadmintruststore
	addwrite /root/.asadminpass
	lib/ant/bin/ant -f ${setupfile}

	chown -R glassfish:glassfish ${GLASSFISH_WORKDIR}

# Remove sunos files as we don't need them
	find ${GLASSFISH_WORKDIR} -type d -name sunos -prune -exec rm -rf {} \;

# Glassfish has a number of hardcoded paths in various files after the setup is
# run.  These need to be modified to work in the real install location.
	einfo "Fixing hardcoded paths from: ${GLASSFISH_WORKDIR} to ${GLASSFISH_INSTALL_BASE}"
	for file in `grep -rl "${GLASSFISH_WORKDIR}" *`; do
		einfo "Fixing path in file: $file"
		sed -i -e "s@${GLASSFISH_WORKDIR}@${GLASSFISH_INSTALL_BASE}@g" $file
	done
	einfo "Fixing hardcoded paths - done"

	diropts -m775 -o glassfish -g glassfish
	dodir ${GLASSFISH_INSTALL_BASE}

	cp -pPR ${GLASSFISH_WORKDIR}/* "${D}"${GLASSFISH_INSTALL_BASE}
	chmod -R 775 "${D}"${GLASSFISH_INSTALL_BASE}

	local envd_dir="${D}/etc/env.d/"
	mkdir -p "${envd_dir}"
	echo "PATH=${GLASSFISH_INSTALL_BASE}/bin" > "${envd_dir}"${GLASSFISH_ENVD_FILE}
	echo "GLASSFISH_HOME=${GLASSFISH_INSTALL_BASE}" >> "${envd_dir}"${GLASSFISH_ENVD_FILE}

	cat <<- EOF > "${D}"${GLASSFISH_GENTOO_README}
	Glassfish Application Server has been installed using the glassfish
	user and glassfish group.  To use Glassfish as another user, add the
	glassfish group to the user.

	To use the Glassfish commands, do 'source /etc/profile'.  This will
	add the ${GLASSFISH_INSTALL_BASE}/bin to your PATH and create the
	GLASSFISH_HOME environment variable as ${GLASSFISH_INSTALL_BASE}.

	To get started with Glassfish, see the Quick Start Guide at:
	https://glassfish.dev.java.net/downloads/quickstart/index.html

	If you remove Glassfish, some files may still exist in ${GLASSFISH_INSTALL_BASE}
	from running Glassfish, e.g. log files, new domains, etc.  The removal
	process deliberately leaves these files alone.
	EOF
	chown glassfish:glassfish "${D}"${GLASSFISH_GENTOO_README}
}

pkg_postinst() {
	einfo "${GLASSFISH_GENTOO_README} contains more information on this installation."
}

pkg_prerm() {
	stop_domains ${GLASSFISH_INSTALL_BASE}
}
