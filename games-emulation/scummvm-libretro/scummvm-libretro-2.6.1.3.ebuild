# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

LIBRETRO_REPO_NAME="libretro/scummvm"
LIBRETRO_COMMIT_SHA="a0554745e87361643f1ca3aa820a5073214de935"
inherit libretro-core

DESCRIPTION="libretro implementation of ScummVM"
HOMEPAGE="https://github.com/libretro/scummvm"
KEYWORDS=""

CREATE_PRINCE_SHA="4e2acb737c936a576dee19927bb0cab5a0ae3b2d"
LIBRETRO_COMMON_SHA="2a4b12d1a3aa69f521b8322ef48b23a4a585b38c"
LIBRETRO_DEPS_SHA="1d35fd986051b3a59be99f3683432fe42b247de7"
SCUMMVM_SHA="4bf45d922baaf68552c9936491d34361ffb467f2"

SRC_URI="https://github.com/libretro/scummvm/archive/${MY_PV}.tar.gz -> ${P}.tar.gz
	https://github.com/scummvm/game-translations/archive/${CREATE_PRINCE_SHA}.tar.gz -> ${PN}-create_prince-${CREATE_PRINCE_SHA:0:7}.tar.gz
	https://github.com/libretro/libretro-common/archive/${LIBRETRO_COMMON_SHA}.tar.gz -> ${PN}-libretro-common-${LIBRETRO_COMMON_SHA:0:7}.tar.gz
	https://github.com/libretro/libretro-deps/archive/${LIBRETRO_DEPS_SHA}.tar.gz -> ${PN}-libretro-deps-${LIBRETRO_DEPS_SHA:0:7}.tar.gz
	https://github.com/scummvm/scummvm/archive/${SCUMMVM_SHA}.tar.gz -> ${PN}-scummvm-${SCUMMVM_SHA:0:7}.tar.gz
"

LICENSE="BSD GPL-2 GPL-2+ LGPL-2.1"
SLOT="0"

DEPEND=""
RDEPEND="${DEPEND}"

src_prepare() {
	rm -rf "${S}/libretro-deps" "${S}/libretro-common" "${S}/scummvm"
	mv "${WORKDIR}/libretro-deps-${LIBRETRO_DEPS_SHA}" "${S}/libretro-deps" || die
	mv "${WORKDIR}/libretro-common-${LIBRETRO_COMMON_SHA}" "${S}/libretro-common" || die
	mv "${WORKDIR}/scummvm-${SCUMMVM_SHA}" "${S}/scummvm" || die
	eapply_user
}

src_install() {
	libretro-core_src_install
	mkdir -p "${D}/usr/share/${PN}"
	cp -r "${S}/scummvm/dists/engine-data" "${D}/usr/share/${PN}"
}


