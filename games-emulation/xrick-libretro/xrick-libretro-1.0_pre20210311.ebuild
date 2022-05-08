# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

LIBRETRO_REPO_NAME="libretro/xrick-libretro"
LIBRETRO_COMMIT_SHA="63065483dde7bed6a6f83d2ba1c953ca52d46199"

inherit libretro-core

DESCRIPTION="Xrick is an open source implementation of Rick Dangerous for libretro."
HOMEPAGE="https://github.com/libretro/xrick-libretro"
KEYWORDS="~amd64 ~x86"

LICENSE="GPL-2"
SLOT="0"

DEPEND=""
RDEPEND="${DEPEND}
		games-emulation/libretro-info"

