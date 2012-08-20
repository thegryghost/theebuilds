# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
EAPI=4

inherit toolchain-funcs eutils base

DESCRIPTION="libhdhomerun"
HOMEPAGE=""
SRC_URI="http://download.silicondust.com/hdhomerun/libhdhomerun_${PV}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

S="${WORKDIR}/libhdhomerun"

src_prepare () {
	chmod -x *
}

src_install () {
	insinto usr/$(get_libdir)
	doins ${S}/libhdhomerun.so

	insinto usr/include
	doins ${S}/*.h

	exeinto usr/bin
	doexe ${S}/hdhomerun_config
}
