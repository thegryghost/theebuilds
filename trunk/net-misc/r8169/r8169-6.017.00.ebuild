# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=4

inherit linux-mod

DESCRIPTION="r8169 driver for Realtek PCI-E NICs"
HOMEPAGE="http://www.realtek.com.tw"
SRC_URI="ftp://WebUser:fh7SkVT4@209.222.7.36/cn/nic/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
IUSE=""

KEYWORDS="~amd64 ~x86"

MODULE_NAMES="r8169(net:${S}/src)"
BUILD_TARGETS="modules"
CONFIG_CHECK="!R8169"

ERROR_R8169="${P} requires Realtek 8169 PCI Gigabit Ethernet adapter (CONFIG_R8169) to be DISABLED"

src_prepare() {
	sed -e 's:#include <asm/system.h://#include <asm/system.h:g' -i src/r8169_n.c
}
pkg_setup() {
	linux-mod_pkg_setup
	BUILD_PARAMS="KERNELDIR=${KV_DIR}"
}

src_install() {
	linux-mod_src_install
}
