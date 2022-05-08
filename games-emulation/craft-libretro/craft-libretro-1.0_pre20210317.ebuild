# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

LIBRETRO_REPO_NAME="libretro/Craft"
LIBRETRO_COMMIT_SHA="d0de2c6d3ff9d971d5c23c796bcb208498f635a9"
inherit libretro-core

DESCRIPTION="Libretro implementation of Craft. (Minecraft clone)"
HOMEPAGE="https://github.com/libretro/Craft"
KEYWORDS="~amd64 ~x86"

LICENSE="Craft"
SLOT="0"

DEPEND=""
RDEPEND="${DEPEND}
		games-emulation/libretro-info"

# PATCHES="${FILESDIR}/clockid.patch"

src_compile() {
	libretro-core_src_compile
}

src_install() {
	insinto "${LIBRETRO_DATA_DIR}"/${PN}
	doins "${S}"/LICENSE.md
	libretro-core_src_install
}
