# Copyright 2021-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop multilib multiprocessing xdg

APP_EXE="${P}.AppImage"

DESCRIPTION="Self-hosted game stream host for Moonlight."
HOMEPAGE="https://app.lizardbyte.dev/"
SRC_URI="https://github.com/LizardByte/Sunshine/releases/download/v${PV}/sunshine.AppImage -> ${APP_EXE}"

DEPEND="app-arch/p7zip"
RDEPEND="${DEPEND}
	dev-libs/libappindicator
	dev-libs/libthai"

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
#	find usr -type d -exec chmod go+rx {} \;
	exeinto /usr/bin
	doexe ${FILESDIR}/sunshine

	exeinto ${OPT_BASE}/bin
	doexe usr/bin/sunshine-${PV}

	exeinto ${OPT_BASE}/lib
	doexe usr/lib/*

	insinto ${OPT_BASE}/
	doins -r usr/share

#	find ${OPT_BASE}/usr -type d -exec chmod go+rx {} \;

	cd ${D}/${OPT_BASE}/bin
	ln -s sunshine-${PV} sunshine
}
