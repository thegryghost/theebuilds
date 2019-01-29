# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

inherit eutils versionator linux-mod user
#inherit autotools eutils flag-o-matic user

DESCRIPTION="Ceton InfiniTV Linux Drivers"
HOMEPAGE="http://www.cetoncorp.com/infinitv/support/linux.php"
SRC_URI="http://cetoncorp.com/downloads/ceton_infinitv_linux_driver_2013_0326_2226.tar.gz"

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
	default
	cd "${S}"
	sed -e 's:KERNEL_VERSION \:=:#KERNEL_VERSION \:=:g' -i Makefile
	sed -e 's:KERNEL_DIR\t\:= :#KERNEL_DIR\t\:= :g' -i Makefile
	sed -e 's:ifdef CROSS_COMPILE:ifdef USE_CROSS_COMPILE:g' -i Makefile
	sed -e 's:-DUSE_INTERNAL=0:-DUSE_INTERNAL=0 -Wno-error=date-time:g' -i Makefile
	epatch ${FILESDIR}/jiffies_47.diff
	epatch ${FILESDIR}/aaddaf5edd0c1b99e4d6761e0283fab5c7a8e0f5.patch
}

src_install() {
	linux-mod_src_install
	insinto /etc/udev/rules.d/
	doins 98-ctn91xx.rules
}
