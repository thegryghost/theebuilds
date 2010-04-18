# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/frostwire/frostwire-4.13.5-r1.ebuild,v 1.3 2008/08/05 18:11:23 wltjr Exp $

#svn export https://frostwire.svn.sourceforge.net/svnroot/frostwire/tags/frostwire_4.17.1_nov_7_2008 frostwire-4.17.1
#tar -cjf frostwire-4.17.1.tar.bz2 frostwire-4.17.1/

EAPI=1

DESCRIPTION="Frostwire Java Gnutella client"
HOMEPAGE="http://www.frostwire.com"
SRC_URI="http://main2.frostwire.com/frostwire/${PV}/${P}.noarch.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
MY_PN="frostwire"


RDEPEND=">=virtual/jre-1.5"
DEPEND=">=virtual/jre-1.5"

PREFIX="/usr/share/${PN}"

#remove before adding to tree
#RESTRICT="fetch"

src_unpack() {
	unpack ${A}
}

src_install() {
	mkdir -p ${D}/opt/${P}
	pwd
        cd ${P}.noarch
	cp -R * ${D}/opt/${MY_PN}-${PV}
	mkdir tmp
	unzip lw-all.jar -d ./tmp > /dev/null
	cp ./tmp/resources/src/main/resources/org/limewire/gui/images/frosticon_linux.png frostwire.png
	ln -sf ${D}/opt/${MY_PN}-${PV} ${D}/opt/${MY_PN}

	sed -i -e "s:/usr/bin/frostwire:/opt/${MY_PN}/runFrostwire.sh:g" frostwire.desktop
	insinto usr/share/pixmaps
	doins frostwire.png
	insinto usr/share/applications
	doins frostwire.desktop
}
