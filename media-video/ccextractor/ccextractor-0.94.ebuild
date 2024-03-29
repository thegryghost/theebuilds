# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake toolchain-funcs

DESCRIPTION="Extract closed captioning subtitles from video to SRT"
HOMEPAGE="https://www.ccextractor.org/"
#SRC_URI="mirror://sourceforge/ccextractor/${PN}-src-nowin.${PV}.zip"
SRC_URI="https://github.com/CCExtractor/ccextractor/archive/v${PV}.zip"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND="
	media-libs/libpng:0=
	sys-libs/zlib:=
"
DEPEND="${RDEPEND}
	app-arch/unzip
	virtual/pkgconfig"

S="${WORKDIR}/${P}/src"

#PATCHES=( "${FILESDIR}/${P}-cmake.patch" )

src_install() {
	cmake-utils_src_install
	dodoc ../docs/*.TXT
}
