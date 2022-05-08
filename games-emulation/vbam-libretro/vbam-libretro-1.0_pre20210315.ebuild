# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

LIBRETRO_REPO_NAME="libretro/vbam-libretro"
LIBRETRO_COMMIT_SHA="109573dea644e957832cbe56255bba50da584de4"

inherit libretro-core

DESCRIPTION="libretro implementation of VBA-M. (Game Boy Advance)"
HOMEPAGE="https://github.com/libretro/vbam-libretro"
KEYWORDS="~amd64 ~x86"

LICENSE="vba"
SLOT="0"

DEPEND=""
RDEPEND="${DEPEND}
		games-emulation/libretro-info"

S="${S}/src/libretro"

