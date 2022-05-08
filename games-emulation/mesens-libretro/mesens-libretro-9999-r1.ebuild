# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

LIBRETRO_REPO_NAME="libretro/Mesen-S"

inherit libretro-core

DESCRIPTION="Mesen-S is a cross-platform (Windows & Linux) SNES emulator built in C++ and C#"
HOMEPAGE="https://github.com/libretro/Mesen-S"
KEYWORDS=""

LICENSE="GPL-3"
SLOT="0"

DEPEND=""
RDEPEND="${DEPEND}
		games-emulation/libretro-info"

S="${S}/Libretro"
LIBRETRO_CORE_NAME="mesen-s"
