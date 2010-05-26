# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header$

EAPI=2

inherit eutils toolchain-funcs flag-o-matic multilib

DESCRIPTION="NVIDIA Linux X11 Settings Utility"
HOMEPAGE="http://www.nvidia.com/"
SRC_URI="ftp://download.nvidia.com/XFree86/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="-* ~amd64 ~x86 ~x86-fbsd"
IUSE=""

# xorg-server is used in the depends as nvidia-settings builds against some
# headers in /usr/include/xorg/.
# This also allows us to optimize out a lot of the other dependancies, as
# between gtk and xorg-server, almost all libraries and headers are accounted
# for.
DEPEND=">=x11-libs/gtk+-2
	dev-util/pkgconfig
	x11-base/xorg-server
	x11-libs/libXt
	x11-libs/libXv
	x11-proto/xf86driproto
	x11-proto/xf86vidmodeproto"

RDEPEND=">=x11-libs/gtk+-2
	x11-base/xorg-server
	x11-libs/libXt
	x11-drivers/nvidia-drivers"

src_prepare() {
	# Fix .desktop
	sed -e "s:__UTILS_PATH__/nvidia-settings:nvidia-settings:" -i doc/nvidia-settings.desktop
	sed -e "s:__PIXMAP_PATH__/nvidia-settings.png:nvidia-settings.png:" -i doc/nvidia-settings.desktop
	sed -e "s:__NVIDIA_SETTINGS_DESKTOP_CATEGORIES__:Application;System;:" -i doc/nvidia-settings.desktop
}

src_compile() {
	einfo "Building libXNVCtrl..."
	cd "${S}/src/libXNVCtrl"
	make clean || die "Cleaning old libXNVCtrl failed"
	append-flags -fPIC
	emake CDEBUGFLAGS="${CFLAGS}" CC="$(tc-getCC)" libXNVCtrl.a || die "Building libXNVCtrl failed!"
	filter-flags -fPIC

	cd "${S}"
	einfo "Building nVidia-Settings..."
	emake CC="$(tc-getCC)" STRIP_CMD="true" || die "Failed to build nvidia-settings"
}

src_install() {
	# Get output dir
	local nvoutdir
	use x86-fbsd && nvoutdir="_out/FreeBSD_x86"
	use amd64 && nvoutdir="_out/Linux_x86_64"
	use x86 && nvoutdir="_out/Linux_x86"

	# Install the executable
	exeinto /usr/bin
	doexe ${nvoutdir}/nvidia-settings

	# Install libXNVCtrl and headers
	insinto "/usr/$(get_libdir)"
	doins src/libXNVCtrl/libXNVCtrl.a
	insinto /usr/include/NVCtrl
	doins src/libXNVCtrl/{NVCtrl,NVCtrlLib}.h

	# Install icon and .desktop entry
	doicon "doc/${PN}.png"
	domenu "doc/${PN}.desktop"

	# Install manpage
	doman ${nvoutdir}/nvidia-settings.1

	# Now install documentation
	dodoc doc/*.txt
}
