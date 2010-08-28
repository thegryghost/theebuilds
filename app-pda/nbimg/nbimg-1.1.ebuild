# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-pda/usbmuxd/usbmuxd-1.0.0_rc2.ebuild,v 1.1 2009/12/07 00:47:08 chainsaw Exp $

EAPI="2"

#inherit base

DESCRIPTION="HTC splash screen tool"
HOMEPAGE="http://pof.eslack.org/blog/2008/07/03/nbimg-htc-splash-screen-tool/"
SRC_URI="http://pof.eslack.org/HTC/nbimg/nbimg-${PV}.tar.gz"

SLOT="0"
LICENSE=""
KEYWORDS="~amd64 ~x86"
IUSE=""

src_compile() {
	gcc nbimg.c -o nbimg
}

src_install() {
	insinto /usr/bin
	doexe nbimg
}
