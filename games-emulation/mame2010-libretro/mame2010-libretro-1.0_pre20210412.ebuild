# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

LIBRETRO_REPO_NAME="libretro/mame2010-libretro"
LIBRETRO_COMMIT_SHA="932e6f2c4f13b67b29ab33428a4037dee9a236a8"

inherit libretro-core

DESCRIPTION="MAME (0.139) for libretro."
HOMEPAGE="https://github.com/libretro/mame2010-libretro"
KEYWORDS="~amd64 ~x86"

LICENSE="MAME-GPL"
SLOT="0"

DEPEND=""
RDEPEND="${DEPEND}
		games-emulation/libretro-info"
