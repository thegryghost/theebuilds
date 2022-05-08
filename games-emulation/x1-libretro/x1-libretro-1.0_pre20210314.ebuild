# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

LIBRETRO_REPO_NAME="libretro/xmil-libretro"
LIBRETRO_COMMIT_SHA="4b4227b5098a21914c04fb873d755e4958928305"

inherit libretro-core

DESCRIPTION="Libretro port of X Millennium Sharp X1 emulator"
HOMEPAGE="https://github.com/libretro/xmil-libretro"
KEYWORDS="~amd64 ~x86"

LICENSE="BSD-3"
SLOT="0"

DEPEND=""
RDEPEND="${DEPEND}
		games-emulation/libretro-info"

S="${S}/libretro"
