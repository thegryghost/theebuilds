# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

CMAKE_MAKEFILE_GENERATOR=emake
inherit cmake desktop

DESCRIPTION="EmulationStation Desktop Edition"
HOMEPAGE="https://es-de.org/"
#SRC_URI="https://gitlab.com/leonstyhre/emulationstation-de/-/archive/v${PV}/emulationstation-de-v${PV}.tar.bz2"
SRC_URI="https://gitlab.com/es-de/emulationstation-de/-/archive/v${PV}/emulationstation-de-v${PV}.tar.bz2"

LICENSE="emulationstation"
SLOT="0"
KEYWORDS="amd64 x86"

S="${WORKDIR}/emulationstation-de-v${PV}"
IUSE="-oldcfg"

DEPEND="
	dev-cpp/eigen:3
	dev-libs/boost
	media-libs/freeimage[png,jpeg]
	media-libs/freetype
	media-libs/libsdl2
	net-misc/curl
	media-libs/freeimage
	dev-libs/pugixml
	app-text/xmlstarlet
	app-text/poppler
	dev-libs/libgit2
	!games-emulation/emulationstation
"
DOCS=( README.md THEMES.md CREDITS.md USERGUIDE.md )


PATCHES=(
        "${FILESDIR}/2.1.1_lunasvg.patch"
        "${FILESDIR}/libgit.patch"
        "${FILESDIR}/str.patch"
)


#src_prepare() {
#	eapply_user
#	cmake_src_prepare
#}

pkg_postinst() {
	ewarn ""
	ewarn "The first start of Emulation Station will fail but also creates"
	ewarn "an example config file at \"\${HOME}/.emulationstation/es_systems.cfg\""
	ewarn ""
	ewarn "Also, don't forget to install some themes."
	ewarn ""
	ewarn "You'll also need to symlink the resources directory into your \"\${HOME}/.emulationstation/\""
	ewarn "ln -s /usr/share/emulationstation/resources \"\${HOME}/.emulationstation/\""
	elog ""
	elog "Current valid platform names for scraping can be found at:"
	elog "\"https://github.com/RetroPie/EmulationStation/blob/master/es-app/src/PlatformId.cpp\""
	elog ""
}
