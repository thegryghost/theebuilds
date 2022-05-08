# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

LIBRETRO_REPO_NAME="libretro/snes9x2005"

inherit libretro-core

DESCRIPTION="Snes9x 2005. Port of SNES9x 1.43 for libretro (previously PocketSNES)"
HOMEPAGE="https://github.com/libretro/snes9x2005"
KEYWORDS=""

LICENSE="snes9x"
SLOT="0"

DEPEND=""
RDEPEND="${DEPEND}
	games-emulation/libretro-info"

