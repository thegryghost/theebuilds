# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

LIBRETRO_REPO_NAME="libretro/mame2000-libretro"
inherit libretro-core

DESCRIPTION="MAME2000 (0.37b5) for libretro."
HOMEPAGE="https://github.com/libretro/mame2000-libretro"
KEYWORDS=""

LICENSE="MAME-GPL"
SLOT="0"

DEPEND=""
RDEPEND="${DEPEND}
		games-emulation/libretro-info"
