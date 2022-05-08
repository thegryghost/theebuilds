# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

LIBRETRO_REPO_NAME="libretro/libretro-vecx"
LIBRETRO_COMMIT_SHA="0f3f04b0e5bbb484a84e3416d07f0ae8cdac386e"

inherit libretro-core

DESCRIPTION="Libretro adaption of vecx, a Vectrex Emulator"
HOMEPAGE="https://github.com/libretro/libretro-vecx"
KEYWORDS="~amd64 ~x86"

LICENSE="GPL-3"
SLOT="0"

DEPEND=""
RDEPEND="${DEPEND}
		games-emulation/libretro-info"
