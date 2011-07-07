# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"

DESCRIPTION="GTK+2 frontend for different search engines (daemons)"
HOMEPAGE="http://software.twotoasts.de/index.php?/pages/catfish_summary.html"
SRC_URI="http://www.twotoasts.de/media/catfish/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="beagle pinot slocate strigi tracker"

DEPEND="dev-python/pygtk
	dev-python/pyxdg
	gnome-base/libglade
	sys-apps/dbus"

RDEPEND="${DEPEND}
	sys-apps/findutils
	beagle? ( app-misc/beagle )
	pinot? ( app-misc/pinot )
	slocate? ( sys-apps/slocate )
	strigi? ( app-misc/strigi )
	tracker? ( app-misc/tracker )"

export PREFIX="/usr"

src_compile() {
	sed -e "s:PREFIX=.*$::g" Makefile.in > Makefile
	emake || die "Make failed"
}

src_install() {
	emake install DESTDIR="${D}" || die "Install failed"
	dodoc AUTHORS ChangeLog README TODO
}
