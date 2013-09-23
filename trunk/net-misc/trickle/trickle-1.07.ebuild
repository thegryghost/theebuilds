# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $
inherit eutils versionator

DESCRIPTION=""
HOMEPAGE="http://monkey.org/~marius/pages/?page=trickle"
SRC_URI="http://monkey.org/~marius/trickle/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=""
RDEPEND="dev-libs/libevent
		dev-libs/libbsd"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch ${FILESDIR}/trickle_1.07-9.diff
#	sed -i '/#include <netinet\/in.h>/d' *.c || die
}

src_install() {
	make DESTDIR="${D}" install || die
	dodoc README TODO
}
