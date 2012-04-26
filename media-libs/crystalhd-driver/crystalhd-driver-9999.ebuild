# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4
EGIT_REPO_URI="git://git.linuxtv.org/jarod/crystalhd.git"
EGIT_SOURCEDIR="${WORKDIR}/${PN}"

inherit eutils autotools linux-mod git-2

DESCRIPTION="Broadcom Crystal HD driver"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
DEPEND="sys-devel/autoconf
	virtual/linux-sources"
RDEPEND=""
S="${WORKDIR}/${PN}/driver/linux"

CONFIG_CHECK="!CRYSTALHD"

pkg_setup() {
	linux-mod_pkg_setup
	MODULE_NAMES="crystalhd(drivers/video/broadcom)"
	BUILD_TARGETS="clean all"
}

src_prepare() {
	# Patch a few issues which have not been fixed upstream.
	epatch "${FILESDIR}/${P}-fix-missing-delay-header.patch"
	epatch "${FILESDIR}/${P}-use-8-dma-buffers.patch"
	epatch "${FILESDIR}/${P}-quiet-dmesg.patch"
	eautoconf
}

src_install() {
	linux-mod_src_install
	insinto /lib/udev/rules.d
	doins 20-crystalhd.rules
}

pkg_postinst() {
	linux-mod_pkg_postinst
}
