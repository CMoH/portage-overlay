# Copyright 2026 Ciprian Ciubotariu
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit java-pkg-2

DESCRIPTION="sbt is a build tool for Scala and Java projects that aims to do the basics well"
HOMEPAGE="https://www.scala-sbt.org/"
EGIT_COMMIT="v${PV}"
EGIT_REPO_URI="https://github.com/sbt/sbt.git"
SRC_URI="
	https://github.com/sbt/sbt/archive/v${PV}.tar.gz -> ${P}.tar.gz
	http://www.cheepee.ro/~cipi/portage/distfiles/${P}-cache-deps.tar.xz
	http://www.cheepee.ro/~cipi/portage/distfiles/${P}-ivy2-deps.tar.xz
	http://www.cheepee.ro/~cipi/portage/distfiles/${P}-sbt-deps.tar.xz
"
SLOT="1.10"
KEYWORDS="amd64 ~arm64"
IUSE=""

# Restrict to jdk:1.8
# Missing dependency 'object java.lang.Object in compiler mirror', bug #831297
DEPEND="
	virtual/jdk:1.8
"

RDEPEND="
	>=virtual/jre-1.8:*
"

# test hangs or fails
RESTRICT="test"

# Note: to bump sbt, some things to try are:
# 1. remove the https://dev.gentoo.org/~gienah/snapshots/${P}-ivy2-deps.tar.xz
# https://dev.gentoo.org/~gienah/snapshots/${P}-sbt-deps.tar.xz and
# binary? ( https://dev.gentoo.org/~gienah/distfiles/${P}-gentoo-binary.tar.xz )
# from SRC_URI
# 2. Comment the sbt publishLocal line in src_compile.
# 3. try:
# FEATURES='noclean -test' emerge -v -1 dev-java/sbt
# It should fail in src_install since the sbt publishLocal is not done.
# Check if it downloads more stuff in
# src_compile to ${WORKDIR}/.ivy2 and ${WORKDIR}/.sbt.
# 4. If some of the downloads fail, it might be necessary to run the sbt compile
# again manually to obtain all the dependencies, if so:
# cd to ${S}
# export EROOT=/
# export WORKDIR='/var/tmp/portage/dev-java/${P}/work'
# export L_P=${P}
# export PATH="${WORKDIR}/${L_P}:${PATH}"
# sbt compile
# cd ${WORKDIR}
# find .ivy2 .sbt -uid 0 -exec chown portage:portage {} \;
# 5. cd ${WORKDIR}
# XZ_OPT=-9 tar --owner=portage --group=portage \
# -cJf /usr/portage/distfiles/${P}-ivy2-deps.tar.xz .ivy2/cache
# XZ_OPT=-9 tar --owner=portage --group=portage \
# -cJf /usr/portage/distfiles/${P}-sbt-deps.tar.xz .sbt
# Uncomment the sbt publishLocal line in src_compile.
# 6. It *might* download more dependencies for src_test, however the presence
# of some of these may cause the src_compile to fail.  So download them
# seperately as root so we can identify the
# additional files.  As root:
# cd ${S}
# ${S}/${P} test
# cd ${WORKDIR}
# XZ_OPT=-9 tar --owner=portage --group=portage \
# -cJf /usr/portage/distfiles/${P}-test-deps.tar.xz \
# $(find .ivy2/cache .sbt -uid 0 -type f -print)
# Note: It might not download anything in src_test, in which case
# ${P}-test-deps.tar.xz is not required.
# 7. Create the binary
# cd $WORDKIR
# XZ_OPT=-9 tar --owner=portage --group=portage \
# -cJf /usr/portage/distfiles/${P}-gentoo-binary.tar.xz ${P} .ivy2/local
# 9. Undo the earlier temporary edits to the ebuild.

src_unpack() {
	# Unpack tar files only.
	for f in ${A} ; do
		[[ ${f} == *".tar."* ]] && unpack ${f}
	done
}

src_prepare() {
	default

	# suppress this warning in build.log:
	# [warn] Credentials file /var/tmp/portage/dev-java/${P}/work/.bintray/.credentials does not exist
	mkdir -p "${WORKDIR}/.bintray" || die
	cat <<- EOF > "${WORKDIR}/.bintray/.credentials"
			realm = Bintray API Realm
			host = api.bintray.com
			user =
			password =
		EOF
}

src_compile() {
	einfo "=== sbt compile ..."
	local vm_version="$(java-config -g PROVIDES_VERSION)"
	"${WORKDIR}/${P}/sbt" -Duser.home="${WORKDIR}" -Dsbt.log.noformat=true -Djava.io.tmpdir="${WORKDIR}" compile || die
	einfo "=== sbt publishLocal with jdk ${vm_version} ..."
	cat <<- EOF | "${WORKDIR}/${P}/sbt" -Duser.home="${WORKDIR}" -Dsbt.log.noformat=true -Djava.io.tmpdir="${WORKDIR}" || die
			set every javaVersionPrefix in javaVersionCheck := Some("${vm_version}")
			publishLocal
			exit
		EOF
}

src_test() {
	"${S}/${P}" -Dsbt.log.noformat=true test || die
}

src_install() {
	# Place sbt-launch.jar at the end of the CLASSPATH
	java-pkg_dojar $(find "${WORKDIR}"/.ivy2/local -name \*.jar -print | grep -v sbt-launch.jar) \
		$(find "${WORKDIR}"/.ivy2/local -name sbt-launch.jar -print)
	local ja="-Dsbt.version=${PV} -Xms512M -Xmx1536M -Xss1M -XX:+CMSClassUnloadingEnabled"
	java-pkg_dolauncher sbt --jar sbt-launch.jar --java_args "${ja}"
}
