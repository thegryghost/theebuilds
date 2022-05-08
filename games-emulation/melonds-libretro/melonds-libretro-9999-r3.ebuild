# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

LIBRETRO_REPO_NAME="libretro/melonDS"

inherit libretro-core

DESCRIPTION="libretro implementation of melonDS. (NintendoDS)"
HOMEPAGE="https://github.com/libretro/melonDS"
KEYWORDS=""

LICENSE="GPL-3"
SLOT="0"

DEPEND=""
RDEPEND="${DEPEND}
		games-emulation/libretro-info"

pkg_postinst() {
	if [[ "${first_install}" == "1" ]]; then
		ewarn ""
		ewarn "You need the following files in your 'system_directory' folder:"
		ewarn "bios7.bin"
		ewarn "bios9.bin"
		ewarn "firmware.bin"
		ewarn ""
	fi
}
