# Copyright 2021-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop multilib multiprocessing xdg

APP_EXE="Minecraft_Bedrock_Launcher-x86_64-v${PV}.AppImage"


DESCRIPTION="Minecraft Bedrock Launcher"
HOMEPAGE="https://mcpelauncher.readthedocs.io/en/latest/"
SRC_URI="https://github.com/minecraft-linux/mcpelauncher-manifest/releases/download/nightly/Minecraft_Bedrock_Launcher-x86_64-v${PV}.AppImage"

DEPEND="app-arch/p7zip"
RDEPEND="${DEPEND}"

LICENSE="all-rights-reserved"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="strip"

src_unpack() {
	mkdir ${WORKDIR}/${P}
	cp ${DISTDIR}/${APP_EXE} ${WORKDIR}/${P}/
	cd ${WORKDIR}/${P}
	7z x ${APP_EXE}
}

src_prepare() {
	default
}

OPT_BASE="/opt/sunshine-bin/squashfs-root/usr"

src_install() {
	echo "install"
	#exeinto /usr/bin
	#doexe ${FILESDIR}/sunshine

	#exeinto ${OPT_BASE}/bin
	#doexe usr/bin/sunshine-${PV}

	#exeinto ${OPT_BASE}/lib
	#doexe usr/lib/*

	#insinto ${OPT_BASE}/
	#doins -r usr/share

	#cd ${D}/${OPT_BASE}/bin
	#ln -s sunshine-${PV} sunshine
}
