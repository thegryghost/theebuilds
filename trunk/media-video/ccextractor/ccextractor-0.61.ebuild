# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/ccextractor/ccextractor-0.59.ebuild,v 1.1 2011/10/08 00:38:21 radhermit Exp $

EAPI=4

inherit toolchain-funcs

DESCRIPTION="Extract closed captioning subtitles from video to SRT"
HOMEPAGE="http://ccextractor.sourceforge.net/"
SRC_URI="mirror://sourceforge/ccextractor/${PN}.src.${PV}.zip"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="app-arch/unzip"

S="${WORKDIR}/${PN}.${PV}"

src_compile() {
	cd src
#	echo "$(tc-getCXX) ${CXXFLAGS} ${LDFLAGS} -D_FILE_OFFSET_BITS=64 -o ccextractor *.cpp"
	echo "$(tc-getCXX) ${CXXFLAGS} ${LDFLAGS} -Wno-write-strings -DGPAC_CONFIG_LINUX  -D_FILE_OFFSET_BITS=64 -Igpacmp4 -lm  -o ccextractor *.cpp *.c gpacmp4/*.c gpacmp4/*.cpp"
	$(tc-getCXX) ${CXXFLAGS} ${LDFLAGS} -Wno-write-strings -DGPAC_CONFIG_LINUX  -D_FILE_OFFSET_BITS=64 -I./gpacmp4 -lm  -o ccextractor $(find . -name '*.cpp') $(find . -name '*.c') || die
}

src_install() {
	dobin src/ccextractor
	dodoc docs/*.TXT
}
