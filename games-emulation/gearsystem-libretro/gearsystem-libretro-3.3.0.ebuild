# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

LIBRETRO_REPO_NAME="drhelius/Gearsystem"
LIBRETRO_COMMIT_SHA="90b01e5270513a2300823c3070918b3dc0ed5098"

inherit libretro-core

DESCRIPTION="Libretro implementation for multiple Sega consoles"
HOMEPAGE="https://github.com/drhelius/Gearsystem"
KEYWORDS="~amd64 ~x86"

LICENSE="GPL-3"
SLOT="0"

DEPEND=""
RDEPEND="${DEPEND}
		games-emulation/libretro-info"

S="${S}/platforms/libretro"
