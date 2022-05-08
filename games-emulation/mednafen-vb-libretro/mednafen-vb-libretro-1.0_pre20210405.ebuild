# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

LIBRETRO_REPO_NAME="libretro/beetle-vb-libretro"
LIBRETRO_COMMIT_SHA="06f9017dbaf0083ad87696728c4f404e689584c0"

inherit libretro-core

DESCRIPTION="libretro implementation of Mednafen VB. (Virtual Boy)"
HOMEPAGE="https://github.com/libretro/beetle-vb-libretro"
KEYWORDS="~amd64 ~x86"

LICENSE="GPL-2"
SLOT="0"

DEPEND=""
RDEPEND="${DEPEND}
		games-emulation/libretro-info"
