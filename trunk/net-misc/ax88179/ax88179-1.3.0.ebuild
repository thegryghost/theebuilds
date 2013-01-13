# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="2"

inherit eutils versionator linux-mod

FNAME="AX88179_178A_LINUX_DRIVER_v${PV}_SOURCE"

DESCRIPTION="USB 3.0 Fast Ethernet AX88179 driver"
HOMEPAGE="http://www.asix.com.tw"
SRC_URI="http://www.asix.com.tw/FrootAttach/driver/${FNAME}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
DEPEND="virtual/linux-sources"
S="${WORKDIR}/${FNAME}"


MODULE_NAMES="ax88179_178a(net:${S})"
BUILD_TARGETS="modules"
#CONFIG_CHECK="!AX8817X"
#ERROR_AX8817X="${P} requires AX88179 USB Ethernet adapter (CONFIG_USB_NET_AX8817X) to be DISABLED"

pkg_setup() {
	linux-mod_pkg_setup
	BUILD_PARAMS="KDIR=${KV_DIR}"
}

src_prepare() {
	cd "${S}"
	sed -e "s:default:modules:g" -i Makefile
}

src_install() {
#	cp src/asix.ko .
	linux-mod_src_install
}
