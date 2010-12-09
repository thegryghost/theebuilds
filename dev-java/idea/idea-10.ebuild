# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit eutils versionator

SLOT="$(get_major_version)"
RDEPEND=">=virtual/jdk-1.6"

MY_PV="99.18"
MY_TYPE="IU"

RESTRICT="strip"
QA_TEXTRELS="opt/${P}/bin/libbreakgen.so"

DESCRIPTION="IntelliJ IDEA is an intelligent Java IDE"
HOMEPAGE="http://jetbrains.com/idea/"
SRC_URI="http://download.jetbrains.com/${PN}/${PN}IU-${PV}.tar.gz
	http://download.jetbrains.com/${PN}/${PN}IC-${PV}.tar.gz"
LICENSE="IntelliJ-IDEA"
IUSE="+community"
KEYWORDS="~x86 ~amd64"
S="${WORKDIR}/${PN}-IU-${MY_PV}"

src_unpack() {
	if use community; then
		MY_TYPE="IC"
		S="${WORKDIR}/${PN}-${MY_TYPE}-${MY_PV}"
	fi
	unpack ${PN}${MY_TYPE}-${PV}.tar.gz
}

src_install() {
	local dir="/opt/${P}"
	insinto "${dir}"
	doins -r *
	fperms 755 "${dir}/bin/${PN}.sh"
	local exe=${PN}-${SLOT}
	local icon=${exe}.png
	newicon "bin/${PN}32.png" ${icon}
	dodir /usr/bin
	cat > "${D}/usr/bin/${exe}" <<-EOF
#!/bin/sh
/opt/${P}/bin/${PN}.sh \$@
EOF
	fperms 755 /usr/bin/${exe}
	make_desktop_entry ${exe} "IntelliJ IDEA ${PV}" ${icon} "Development;IDE"
}
