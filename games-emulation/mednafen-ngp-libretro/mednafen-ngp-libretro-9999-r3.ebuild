# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

LIBRETRO_REPO_NAME="libretro/beetle-ngp-libretro"

inherit libretro-core

DESCRIPTION="libretro implementation of Mednafen Neopop. Neo Geo Pocket/Neo Geo Pocket Color"
HOMEPAGE="https://github.com/libretro/beetle-ngp-libretro"
KEYWORDS=""

LICENSE="GPL-2"
SLOT="0"

DEPEND=""
RDEPEND="${DEPEND}
		games-emulation/libretro-info"
