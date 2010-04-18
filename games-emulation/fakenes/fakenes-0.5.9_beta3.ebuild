# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/fakenes/fakenes-0.5.8.ebuild,v 1.5 2007/10/01 19:11:22 opfer Exp $

inherit eutils flag-o-matic toolchain-funcs games

MY_PV="0.5.9-beta3"
DESCRIPTION="portable, Open Source NES emulator which is written mostly in C"
HOMEPAGE="http://fakenes.sourceforge.net/"
#SRC_URI="mirror://${PN}.sourceforge.net/${PN}-${MY_PV}.tar.gz"
SRC_URI="http://downloads.sourceforge.net/project/fakenes/FakeNES/0.5.9%20beta%203/${PN}-${MY_PV}.tar.gz"
LICENSE="ZLIB"
SLOT="0"
KEYWORDS="~amd64 x86"
IUSE="openal opengl zlib"

DEPEND=">=media-libs/allegro-4.2
	dev-games/hawknl
	opengl? ( media-libs/allegrogl )
	openal? (
		media-libs/openal
		media-libs/freealut )
	zlib? ( sys-libs/zlib )"

S="${WORKDIR}/${PN}-${MY_PV}"

src_compile() {
	local myconf

	append-ldflags -Wl,-z,noexecstack

	$(tc-getCC) ${CFLAGS} cbuild.c -o cbuild || die "cbuild build failed"

	use openal || myconf="$myconf -openal"
	use opengl || myconf="$myconf -alleggl"
	use zlib   || myconf="$myconf -zlib"

	./cbuild ${myconf} || die "cbuild failed"
}

src_install() {
	dogamesbin fakenes || die "dogamesbin failed"
	insinto "${GAMES_DATADIR}/${PN}"
	doins support/* || die "doins failed"
	dodoc docs/{CHANGES,README}
	dohtml docs/faq.html
	prepgamesdirs
}

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${P}-sound_init.patch"
	epatch "${FILESDIR}/${P}-nogui.patch"
}

