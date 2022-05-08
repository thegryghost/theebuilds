# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake git-r3
EGIT_REPO_URI="https://github.com/libretro/citra.git"

DESCRIPTION="Libretro implementation of citra"
HOMEPAGE="https://github.com/libretro/citra"
KEYWORDS="~amd64"
#EGIT_SUBMODULES=( 'boost' 'soundtouch' 'discord-rpc' 'cpp-jwt' 'ent')
#EGIT_SUBMODULES=( '*' '-externals/ffmpeg' '-boost' '-libusb')
#EGIT_SUBMODULES=( '*' '-externals/ffmpeg' '-boost' '-libusb' '-zstd' '-enet' '-catch' '-inih' '-cryptopp')
#EGIT_SUBMODULES=( '*' '-externals/ffmpeg')
EGIT_SUBMODULES=( '')

CMAKE_MAKEFILE_GENERATOR="emake"
CMAKE_BUILD_TYPE="Release"
BUILD_SHARED_LIBS="OFF"

LICENSE="GPL-2"
SLOT="0"

RDEPEND=""
DEPEND="${RDEPEND}
	media-video/ffmpeg"

#PATCHES=("${FILESDIR}/no_room.patch")

src_prepare() {
	default
	pwd
	git checkout  b1959d07a340bfd9af65ad464fd19eb6799a96ef
	git submodule update --init
	sed -e 's/MINSIGSTKSZ/_SC_MINSIGSTKSZ/g' -i externals/catch/single_include/catch2/catch.hpp
	sed -e 's/MINSIGSTKSZ/_SC_MINSIGSTKSZ/g' -i externals/catch/include/internal/catch_fatal_condition.cpp
	sed -e 's/MINSIGSTKSZ/_SC_MINSIGSTKSZ/g' -i externals/dynarmic/externals/catch/catch.hpp
	eapply "${FILESDIR}/no_room.patch"
	echo "PREPARE"
	cmake_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DENABLE_SDL2=OFF
		-DENABLE_QT=OFF
		-DENABLE_LIBRETRO=ON
		-DENABLE_WEB_SERVICE=OFF
		-DBUILD_SHARED_LIBS=OFF
		-DUSE_DISCORD_PRESENCE=OFF
	)
	cmake_src_configure
}


src_install() {
        LIBRETRO_LIB_DIR=
        insinto "usr/$(get_libdir)/libretro"
        doins "${WORKDIR}/${PF}_build/src/citra_libretro/citra_libretro.so"
}



