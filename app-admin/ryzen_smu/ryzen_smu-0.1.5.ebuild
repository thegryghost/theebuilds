# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit linux-mod-r1

DESCRIPTION="Kernel driver for AMD Ryzen's System Management Unit"
HOMEPAGE="https://github.com/leogx9r/ryzen_smu"
SRC_URI="https://gitlab.com/leogx9r/ryzen_smu/-/archive/v${PV}/$P.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"

src_compile() {
	local modlist=( ryzen_smu )
	local modargs=( KERNEL_BUILD="${KV_OUT_DIR}" )

	linux-mod-r1_src_compile
}

S="${WORKDIR}/${PN}-v${PV}"

src_unpack() {
	unpack ${A}
	_SRC=`ls ${WORKDIR}`
	mv "${WORKDIR}/${_SRC}" "${S}"
}

src_install() {
	linux-mod-r1_src_install

	insinto /usr/lib/modules-load.d
	doins "${FILESDIR}"/ryzen_smu.conf
}
