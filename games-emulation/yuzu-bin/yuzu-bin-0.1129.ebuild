# Copyright 2021-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop multilib multiprocessing xdg

MY_PN=${PN/-bin/}
MY_PN_BIN=${PN/-bin/d}
MY_MAJOR=$(ver_cut 1)
MY_MINOR=$(ver_cut 2-)

HASH="8209d07a5"
DATE="20220811"
TAGNAME="mainline-0-1129"


APP="yuzu-linux-${DATE}-${HASH}"
DESCRIPTION="Experimental Nintendo Switch emulator"
HOMEPAGE="https://github.com/yuzu-emu/yuzu-mainline"
SRC_URI="https://github.com/yuzu-emu/yuzu-mainline/releases/download/mainline-0-1129/${APP}.tar.xz"

DEPEND="dev-util/patchelf"
RDEPEND="${DEPEND}
	app-eselect/eselect-yuzu
	app-arch/lz4
	app-arch/zstd
	dev-libs/inih
	dev-libs/libfmt
	dev-libs/libzip
	dev-libs/openssl
	dev-qt/qtcore
	dev-qt/qtgui
	dev-qt/qtwidgets
	media-libs/libsdl2
	media-libs/opus
	media-video/ffmpeg
	sys-libs/zlib
	virtual/libusb:="

LICENSE="all-rights-reserved"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="strip"

S="${WORKDIR}/${APP}"

src_prepare() {
	default
	patchelf --remove-rpath yuzu || die
	patchelf --remove-rpath yuzu-cmd || die
}

src_install() {
	pwd
	exeinto /opt/yuzu
	doexe yuzu
	doexe yuzu-cmd
	dosym /opt/yuzu/yuzu /usr/bin/yuzu-bin || die
}

pkg_postinst() {
	eselect yuzu update ifunset
}

pkg_postrm() {
	eselect yuzu update ifunset
}
