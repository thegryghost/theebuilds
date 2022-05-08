# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

LIBRETRO_REPO_NAME="libretro/vitavoyager"
LIBRETRO_COMMIT_SHA="58b70dd7ea891c2e8ddc37d03a5d58116b0ea118"

inherit libretro-core

DESCRIPTION="lilium-voyager (Star Trek Voyager: Elite Force Holomatch mp) for libretro"
HOMEPAGE="https://github.com/libretro/vitavoyager"
KEYWORDS="~amd64 ~x86"

LICENSE="GPL-2"
SLOT="0"

DEPEND=""
RDEPEND="${DEPEND}
	games-emulation/libretro-info"

S="${WORKDIR}"/vitaVoyager-"${LIBRETRO_COMMIT_SHA}"
