# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils

DESCRIPTION=""
HOMEPAGE="http://christian.amsuess.com/tools/arandr/"
SRC_URI="http://www.ibiblio.org/pub/linux/apps/mjpegtools_yuv_to_v4l-0.2.tgz"

SLOT=0

KEYWORDS="x86 amd64"

src_install() {
	exeinto /usr/bin
	doexe mjpegtools_yuv_to_v4l
}
