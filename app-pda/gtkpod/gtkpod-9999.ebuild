# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit git eutils

EGIT_REPO_URI="git://gtkpod.git.sourceforge.net/gitroot/gtkpod/gtkpod"
EGIT_BOOTSTRAP="./autogen.sh"

DESCRIPTION="GUI for iPod using GTK2"
HOMEPAGE="http://gtkpod.sourceforge.net"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="aac flac gnome hal ogg"

DEPEND=">=x11-libs/gtk+-2.6.0
	>=media-libs/libid3tag-0.15
	>=gnome-base/libglade-2.4
	>=gnome-base/libgnomecanvas-2.14
	>=media-libs/libgpod-0.6.0
	>=net-misc/curl-7.10
	gnome? ( >=gnome-base/gnome-vfs-2.6 )
	hal? ( =sys-apps/hal-0.5* )
	aac? ( media-libs/libmp4v2 )
	ogg? ( media-libs/libvorbis )
	flac? ( media-libs/flac )"
RDEPEND="${DEPEND}"

pkg_setup() {
	ewarn "This is a LIVE SVN ebuild."
	ewarn "That means there are NO promises it will work."
}

src_compile() {
	econf \
		$(use_with hal) \
		$(use_with aac mp4v2) \
		$(use_with ogg) \
		$(use_with flac) \
		$(use_with gnome gnome-vfs ) \
		|| die "econf failed"
	emake || die "emake failed"
}

src_install() {
	make install DESTDIR="${D}" || die
	dodoc README TROUBLESHOOTING
}
