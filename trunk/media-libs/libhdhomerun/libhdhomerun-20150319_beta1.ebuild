# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libhdhomerun/libhdhomerun-20140121.ebuild,v 1.1 2014/05/04 01:27:42 cardoe Exp $

EAPI=5

inherit eutils versionator

DESCRIPTION="SiliconDust HDHomeRun Utilties"
HOMEPAGE="http://www.silicondust.com/support/hdhomerun/downloads/linux/"

GUI_PN="hdhomerun_config_gui"

MY_PV="$(delete_version_separator _)"
SRC_URI="http://download.silicondust.com/hdhomerun/${PN}_${MY_PV}.tgz
         http://download.silicondust.com/hdhomerun/${GUI_PN}_${MY_PV}.tgz"

LICENSE="LGPL-3+"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+gui"

DEPEND="gui? (
			x11-libs/gtk+:2
			media-libs/fontconfig
			media-libs/freetype
			x11-libs/gdk-pixbuf
			)"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${PN}"
S_GUI="${WORKDIR}/$GUI_PN"

src_prepare() {
	epatch "${FILESDIR}/dont-strip.patch"
	if use gui; then
		unpack ${GUI_PN}_${MY_PV}.tgz
	fi
}

src_configure() {
	if use gui; then
		cd $S_GUI
		econf
	else
		:
	fi

}

src_compile() {
	emake
	if use gui; then
		cd "$S_GUI/src"
		emake
	fi
}

src_install() {
	if use gui; then
		dobin "$S_GUI/src/$GUI_PN"
	fi

	dobin hdhomerun_config
	dolib libhdhomerun.so

	insinto /usr/include/hdhomerun
	doins *.h
}
