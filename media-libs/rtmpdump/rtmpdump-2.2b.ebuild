# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit eutils

DESCRIPTION="RTMP stream dumper"
HOMEPAGE="http://rtmpdump.mplayerhq.hu/"
SRC_URI="http://rtmpdump.mplayerhq.hu/download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"

RDEPEND=""

src_compile() {
	emake posix
}

src_install() {
	doman ${PN}.1
	dodoc README
	dobin ${PN} rtmpgw rtmpsrv rtmpsuck
}
