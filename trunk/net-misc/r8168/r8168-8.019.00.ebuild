# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

inherit linux-mod

DESCRIPTION="r8168 driver for Realtek 8111/8168 PCI-E NICs"
HOMEPAGE="http://www.realtek.com.tw"
SRC_URI="http://r8168.googlecode.com/files/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
RESTRICT=""
DEPEND="virtual/linux-sources"
RDEPEND=""

MODULE_NAMES="r8168(net:${S})"
BUILD_TARGETS="modules"
CONFIG_CHECK="!R8169"

ERROR_R8169="${P} requires Realtek 8169 PCI Gigabit Ethernet adapter (CONFIG_R8169) to be DISABLED"

pkg_setup() {
	linux-mod_pkg_setup
	BUILD_PARAMS="KDIR=${KV_DIR}"
}

src_install() {
	cp src/r8168.ko .
	linux-mod_src_install
}
