# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake git-r3
EGIT_REPO_URI="https://github.com/libretro/citra.git"

DESCRIPTION="Libretro implementation of citra"
HOMEPAGE="https://github.com/libretro/citra"
KEYWORDS=""
#EGIT_SUBMODULES=( 'boost' 'soundtouch' 'discord-rpc' 'cpp-jwt' 'ent')
#EGIT_SUBMODULES=( '*' '-externals/ffmpeg' '-boost' '-libusb')
#EGIT_SUBMODULES=( '*' '-externals/ffmpeg' '-boost' '-libusb' '-zstd' '-enet' '-catch' '-inih' '-cryptopp')
EGIT_SUBMODULES=( '*' '-externals/ffmpeg')
#EGIT_SUBMODULES=( '*')

CMAKE_MAKEFILE_GENERATOR="emake"
CMAKE_BUILD_TYPE="Release"
BUILD_SHARED_LIBS="OFF"
LICENSE="GPL-2"
SLOT="0"

RDEPEND=""
DEPEND="${RDEPEND}
	media-video/ffmpeg"

PATCHES=("${FILESDIR}/gitmodules.patch" "${FILESDIR}/no_room.patch" "${FILESDIR}/language_state.patch")

src_configure() {
	local mycmakeargs=(
		-DSTATIC_LINKING=1
		-DCITRA_USE_BUNDLED_FFMPEG=OFF
		-DUSE_SYSTEM_BOOST=ON
		-DUSE_DISCORD_PRESENCE=OFF
		-DBUILD_SHARED_LIBS=OFF
                -DUSE_SYSTEM_BOOST=ON
		-DENABLE_QT=OFF
		-DENABLE_QT_TRANSLATION=OFF
		-DENABLE_SDL2=OFF
		-DENABLE_LIBRETRO=ON
		-DLIBRETRO_STATIC=1
		-DENABLE_WEB_SERVICE=OFF
                -DENABLE_FFMPEG_AUDIO_DECODER=ON
                -DENABLE_FFMPEG_VIDEO_DUMPER=ON
	)
	cmake_src_configure
}


src_install() {
        LIBRETRO_LIB_DIR=
        insinto "usr/$(get_libdir)/libretro"
        doins "${WORKDIR}/${PF}_build/src/citra_libretro/citra_libretro.so"
}



