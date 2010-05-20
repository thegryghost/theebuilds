# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit distutils

DESCRIPTION="A simple PyGTK front end for XRandR 1.2 (client side X only)"
HOMEPAGE="http://christian.amsuess.com/tools/arandr/"
SRC_URI="http://christian.amsuess.com/tools/arandr/files/${P}.tar.gz"
LICENSE="GPL-3"

SLOT="0"
KEYWORDS="~x86 ~amd64"

IUSE=""
DEPEND=""
RDEPEND="${DEPEND}
	>=dev-python/pygtk-2.10
	>=x11-apps/xrandr-1.2
	>=dev-python/docutils-0.6"

PYTHON_MODNAME="screenlayout"
