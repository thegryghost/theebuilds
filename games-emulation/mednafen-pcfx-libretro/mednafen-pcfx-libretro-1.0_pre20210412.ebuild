# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

LIBRETRO_REPO_NAME="libretro/beetle-pcfx-libretro"
LIBRETRO_COMMIT_SHA="ceff11eab32febfcf8507f0bfe618bcdf80e75ef"

inherit libretro-core

DESCRIPTION="Standalone port of Mednafen PCFX to libretro."
HOMEPAGE="https://github.com/libretro/beetle-pcfx-libretro"
KEYWORDS="~amd64 ~x86"

LICENSE="GPL-2"
SLOT="0"

DEPEND=""
RDEPEND="${DEPEND}
		games-emulation/libretro-info"
