# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake desktop

DESCRIPTION="Frontend for emulators (RetroPie Fork)"
HOMEPAGE="https://github.com/RetroPie/EmulationStation"


if [[ ${PV} == *9999 ]]; then
	#EGIT_REPO_URI="https://github.com/EmuELEC/emuelec-emulationstation.git"
	EGIT_REPO_URI="https://github.com/batocera-linux/batocera-emulationstation.git"
	#EGIT_REPO_URI="https://github.com/RetroPie/EmulationStation.git"
	EGIT_BRANCH="master"
	inherit git-r3
	S="${WORKDIR}/emulationstation-${PV}"
else
	SRC_URI="https://github.com/RetroPie/EmulationStation/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	S="${WORKDIR}/EmulationStation-${PV}"
	PATCHES=( "${FILESDIR}/${P}-include-fix.patch" )
fi



LICENSE="emulationstation"
SLOT="0"
#KEYWORDS="~amd64 ~x86"


DEPEND="
	dev-cpp/eigen:3
	dev-libs/boost
	media-libs/freeimage[png,jpeg]
	media-libs/freetype
	media-libs/libsdl2
	media-libs/sdl2-mixer
	net-misc/curl
	media-video/vlc
	dev-libs/pugixml
	app-text/xmlstarlet
	!games-emulation/emulationstation-de
"

DOCS=( README.md SYSTEMS.md THEMES.md GAMELISTS.md DEVNOTES.md CREDITS.md )

src_install() {
	mkdir -p "${D}/usr/share/emulationstation"
	cp -r "${S}/resources" "${D}/usr/share/emulationstation"
	exeinto /usr/bin
	doexe emulationstation
	doicon "${FILESDIR}/emulationstation.png"
	domenu "${FILESDIR}/emulationstation.desktop"
}

#pkg_preinst() {
#	if ! has_version "=${CATEGORY}/${PN}-${PVR}"; then
#		first_install="1"
#	fi
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
