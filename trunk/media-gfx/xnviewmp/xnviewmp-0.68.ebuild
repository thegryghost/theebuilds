# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils

MY_PV=${PV/.}

DESCRIPTION="XnView MP image viewer/converter"
HOMEPAGE="http://www.xnview.com/"
SRC_URI="amd64? ( http://download.xnview.com/XnViewMP-${MY_PV}-linux-x64.tgz )
	x86? ( http://download.xnview.com/XnViewMP-${MY_PV}-linux.tgz )"

SLOT="0"
LICENSE="free-noncomm as-is"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-lang/perl
	dev-libs/glib:2
	dev-libs/libxml2
	media-libs/fontconfig
	media-libs/freetype
	media-libs/gst-plugins-base:0.10
	media-libs/gstreamer:0.10
	media-libs/ilmbase
	media-libs/libpng:1.2
	virtual/jpeg
	media-libs/mesa
	sys-libs/zlib
	x11-libs/libSM
	x11-libs/libXext
	x11-libs/libXrender"
DEPEND=""

RESTRICT="strip"
S="${WORKDIR}/XnView"

src_install() {
	local XNVIEW_HOME=/opt/XnView

	# Install XnView in /opt
	dodir ${XNVIEW_HOME%/*}
	cp -a "${S}" "${D}"${XNVIEW_HOME} \
		|| die "Unable to install XnView folder"

	# Create /opt/bin/xnview
	dodir /opt/bin/
	cat <<EOF >"${D}"/opt/bin/xnview
#!/bin/sh
LD_LIBRARY_PATH=/opt/XnView/lib
export LD_LIBRARY_PATH
QT_PLUGIN_PATH=/opt/XnView/lib
export QT_PLUGIN_PATH
exec /opt/XnView/XnView "\$@"
EOF
	fperms 0755 /opt/bin/xnview

	# Install icon and .desktop for menu entry
	newicon "${D}"${XNVIEW_HOME}/xnview.png ${PN}.png
	make_desktop_entry xnview XnviewMP ${PN} "Graphics"
}
