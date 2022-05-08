# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

LIBRETRO_REPO_NAME="libretro/meteor-libretro"

inherit libretro-core

DESCRIPTION="libretro implementation of Meteor. (Game Boy Advance)"
HOMEPAGE="https://github.com/libretro/meteor-libretro"
KEYWORDS=""

LICENSE="GPL-3"
SLOT="0"

DEPEND=""
RDEPEND="${DEPEND}
		games-emulation/libretro-info"

S="${S}/libretro"
