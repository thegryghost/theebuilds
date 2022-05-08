# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

LIBRETRO_REPO_NAME="libretro/mame2003-plus-libretro"
LIBRETRO_COMMIT_SHA="94ac642f1e5ade856d8a6a914dd8a648db2f01ce"
inherit libretro-core

DESCRIPTION="MAME (0.78) with extra features for libretro."
HOMEPAGE="https://github.com/libretro/mame2003-plus-libretro"
KEYWORDS="~amd64 ~x86"

LICENSE="MAME-GPL"
SLOT="0"

DEPEND=""
RDEPEND="${DEPEND}
		games-emulation/libretro-info"

LIBRETRO_CORE_LIB_FILE="${S}"/mame2003_plus_libretro.so
