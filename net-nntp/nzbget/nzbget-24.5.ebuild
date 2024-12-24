# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
CMAKE_MAKEFILE_GENERATOR=emake

inherit cmake systemd

PAR2TURBO="1.1.1-nzbget-20241128"

DESCRIPTION="A command-line based binary newsgrabber supporting .nzb files"
HOMEPAGE="https://nzbget.com/"
SRC_URI="https://github.com/nzbgetcom/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz
         https://github.com/nzbgetcom/par2cmdline-turbo/archive/refs/tags/v${PAR2TURBO}.tar.gz -> ${PN}_par2turbo_${PAR2TURBO}.tar.gz"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~ppc ~x86"
IUSE="gnutls ncurses +parcheck ssl test zlib"
RESTRICT="!test? ( test )"

DEPEND="
	dev-libs/boost:=
	dev-libs/libxml2:=
	ncurses? ( sys-libs/ncurses:0= )
	ssl? (
		gnutls? (
			net-libs/gnutls:=
			dev-libs/nettle:=
		)
		!gnutls? ( dev-libs/openssl:0=[-bindist(-)] )
	)
	zlib? ( sys-libs/zlib:= )"
RDEPEND="
	${DEPEND}
	acct-user/nzbget
	acct-group/nzbget
"
BDEPEND="
	test? (
		|| (
			app-arch/rar
			app-arch/unrar
		)
	)
	virtual/pkgconfig
"

DOCS=( ChangeLog.md README.md nzbget.conf )


PATCHES=( ${FILESDIR}/par2turbo.patch )

src_prepare() {
	cmake_src_prepare

	# Update the main configuration file with the correct paths
	sed -i nzbget.conf \
		-e "s:^WebDir=.*:WebDir=${EPREFIX}/usr/share/nzbget/webui:" \
		-e "s:^ConfigTemplate=.*:ConfigTemplate=${EPREFIX}/usr/share/nzbget/nzbget.conf:" \
		|| die
	# Update the daemon-specific configuration file (used by the OpenRC and
	# systemd services)
	sed nzbget.conf > nzbgetd.conf \
		-e "s:^MainDir=.*:MainDir=${EPREFIX}/var/lib/nzbget:" \
		-e "s:^LogFile=.*:LogFile=${EPREFIX}/var/log/nzbget/nzbget.log:" \
		-e 's:^DaemonUsername=.*:DaemonUsername=nzbget:' \
		|| die
}

BUILD_DIR="${WORKDIR}/${P}_build"
PAR2_SRC_DIR="${BUILD_DIR}/par2-turbo/src/par2-turbo"
PAR2_BUILD_DIR="${BUILD_DIR}/par2-turbo/src/par2-turbo-build"
PAR2_STAMP_DIR="${BUILD_DIR}/par2-turbo/src/par2-turbo-stamp"

src_configure() {
	PAR2_PATH="${DISTDIR}/${PN}_par2turbo_${PAR2TURBO}.tar.gz"
	sed -i "${S}/cmake/par2-turbo.cmake" \
		-e "s:REPLACE_URL_ME:${PAR2_PATH}:" \
		|| die

	local mycmakeargs=(
		-DDISABLE_CURSES=$(usex !ncurses)
		-DDISABLE_PARCHECK=$(usex !parcheck)
		-DDISABLE_TLS=$(usex !ssl)
		-DDISABLE_GZIP=$(usex !zlib)
		-DUSE_OPENSSL=$(usex !gnutls)
		-DUSE_GNUTLS=$(usex gnutls)
		-DENABLE_TESTS=$(usex test)
	)
	cmake_src_configure
}

src_install() {
	cmake_src_install

	insinto /etc
	doins nzbget.conf
	doins nzbgetd.conf

	# The configuration file's "ConfigTemplate" option points to this, we must
	# make sure it exists as the Web UI reads it. It is not installed by
	# default, see the "install-conf" target in cmake/install.cmake.
	insinto /usr/share/nzbget
	doins nzbget.conf

	keepdir /var/log/nzbget

	newinitd "${FILESDIR}"/nzbget.initd-r1 nzbget
	newconfd "${FILESDIR}"/nzbget.confd nzbget
	systemd_dounit "${FILESDIR}"/nzbget.service
}

pkg_preinst() {
	fowners nzbget:nzbget /var/log/nzbget
	fperms 750 /var/log/nzbget

	fowners nzbget:nzbget /etc/nzbgetd.conf
	fperms 640 /etc/nzbgetd.conf
}

pkg_postinst() {
	if [[ -z ${REPLACING_VERSIONS} ]] ; then
		elog
		elog "Please add users that you want to be able to use the system-wide"
		elog "nzbget daemon to the nzbget group. To access the daemon, run nzbget"
		elog "with the --configfile /etc/nzbgetd.conf option."
		elog
	fi
}
