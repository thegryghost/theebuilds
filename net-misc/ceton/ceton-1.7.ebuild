# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="4"

inherit eutils versionator linux-mod

DESCRIPTION="Ceton InfiniTV Linux Drivers"
HOMEPAGE="http://www.cetoncorp.com/infinitv/support/linux.php"
SRC_URI="http://cetoncorp.com/downloads/ceton_infinitv_linux_driver_1_7.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
DEPEND="virtual/linux-sources"
S="${WORKDIR}/ceton_infinitv_linux_driver"


MODULE_NAMES="ctn91xx(misc:${S})"
BUILD_TARGETS="ctn91xx"

pkg_setup() {
	linux-mod_pkg_setup
	BUILD_PARAMS="KERNEL_DIR=${KV_DIR} KERNEL_VERSION=${KV_FULL}"
}

src_prepare() {
	cd "${S}"
	rm Module.symvers
	sed -e 's:KERNEL_VERSION \:=:#KERNEL_VERSION \:=:g' -i Makefile
	sed -e 's:KERNEL_DIR\t\:= :#KERNEL_DIR\t\:= :g' -i Makefile
	sed -e 's:ifdef CROSS_COMPILE:ifdef USE_CROSS_COMPILE:g' -i Makefile
}

src_install() {
	linux-mod_src_install
	insinto /etc/udev/rules.d/
	doins 98-ctn91xx.rules
}
