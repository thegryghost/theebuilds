# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/wine/wine-1.1.24.ebuild,v 1.1 2009/06/19 19:11:37 vapier Exp $

EAPI="2"

inherit multilib eutils

RESTRICT="nomirror"

MY_P="${PN}-${PV/_/-}"
#SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.bz2"
SRC_URI="http://media.codeweavers.com/pub/crossover/source/crossover-wine-src-${PV}.tar.gz"
KEYWORDS="~amd64 ~x86"

DESCRIPTION="free implementation of Windows(tm) on Unix"
HOMEPAGE="http://www.codeweavers.com"/

LICENSE="LGPL-2.1"
SLOT="0"
IUSE="alsa cups dbus esd +gecko gnutls hal jack jpeg lcms ldap nas ncurses +opengl oss png samba scanner ssl win64 +X xcomposite xinerama xml"
RESTRICT="test" #72375

RDEPEND=">=media-libs/freetype-2.0.0
	media-fonts/corefonts
	dev-lang/perl
	dev-perl/XML-Simple
	ncurses? ( >=sys-libs/ncurses-5.2 )
	jack? ( media-sound/jack-audio-connection-kit )
	dbus? ( sys-apps/dbus )
	gnutls? ( net-libs/gnutls )
	hal? ( sys-apps/hal )
	X? (
		x11-libs/libXcursor
		x11-libs/libXrandr
		x11-libs/libXi
		x11-libs/libXmu
		x11-libs/libXxf86vm
		x11-apps/xmessage
	)
	alsa? ( media-libs/alsa-lib[midi] )
	esd? ( media-sound/esound )
	nas? ( media-libs/nas )
	cups? ( net-print/cups )
	opengl? ( virtual/opengl )
	jpeg? ( media-libs/jpeg )
	ldap? ( net-nds/openldap )
	lcms? ( media-libs/lcms )
	samba? ( >=net-fs/samba-3.0.25 )
	xml? ( dev-libs/libxml2 dev-libs/libxslt )
	scanner? ( media-gfx/sane-backends )
	ssl? ( dev-libs/openssl )
	png? ( media-libs/libpng )
	win64? ( >=sys-devel/gcc-4.4.0 )
	!win64? ( amd64? (
		X? (
			>=app-emulation/emul-linux-x86-xlibs-2.1
			>=app-emulation/emul-linux-x86-soundlibs-2.1
		)
		app-emulation/emul-linux-x86-baselibs
		>=sys-kernel/linux-headers-2.6
	) )"
DEPEND="${RDEPEND}
	X? (
		x11-proto/inputproto
		x11-proto/xextproto
		x11-proto/xf86vidmodeproto
	)
	sys-devel/bison
	sys-devel/flex"

src_unpack() {
	unpack ${A}
}

src_prepare() {
	cd sources/wine
	epatch "${FILESDIR}"/${PN}-1.1.15-winegcc.patch #260726
	sed -i '/^UPDATE_DESKTOP_DATABASE/s:=.*:=true:' tools/Makefile.in || die
	sed -i '/^MimeType/d' tools/wine.desktop || die #117785
	sed -i "s/cxfreetype/freetype/g" configure || die
	sed -i "s/cxfreetype/freetype/g" configure.ac || die
	sed -i "s/cxfreetype/freetype/g" dlls/wineps.drv/truetype.c || die
	sed -i "s/cxfreetype/freetype/g" dlls/gdi32/freetype.c || die
}

src_configure() {
	export LDCONFIG=/bin/true

	cd sources/wine

	use amd64 && ! use win64 && multilib_toolchain_setup x86

	# XXX: should check out these flags too:
	#	audioio capi fontconfig freetype gphoto
	econf \
		--sysconfdir=/etc/wine \
		--prefix=/opt/cx_gentoo \
		$(use_with alsa) \
		$(use_with cups) \
		$(use_with esd) \
		$(use_with gnutls) \
		$(! use dbus && echo --without-hal || use_with hal) \
		$(use_with jack) \
		$(use_with jpeg) \
		$(use_with lcms cms) \
		$(use_with ldap) \
		$(use_with nas) \
		$(use_with ncurses curses) \
		$(use_with opengl) \
		$(use_with oss) \
		$(use_with png) \
		$(use_with scanner sane) \
		$(use_with ssl openssl) \
		$(use_enable win64) \
		$(use_with X x) \
		$(use_with xcomposite) \
		$(use_with xinerama) \
		$(use_with xml) \
		$(use_with xml xslt) \
		|| die "configure failed"

	emake -j1 depend || die "depend"
}

src_compile() {
	cd sources/wine
	emake all || die "all"
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc ANNOUNCE AUTHORS README
	if use gecko ; then
		insinto /usr/share/wine/gecko
		doins "${DISTDIR}"/wine_gecko-${GV}.cab || die
	fi
}
