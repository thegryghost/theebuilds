# Copyright 2020-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit cmake xdg-utils git-r3

DESCRIPTION="A Nintendo 3DS emulator."
HOMEPAGE="https://citra-emu.org/"

EGIT_REPO_URI="https://github.com/citra-emu/citra.git"
EGIT_COMMIT=b5ac9e494615444f5b7144e7c818bee52cacbaee

LICENSE="ZLIB BSD GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="app-arch/zstd
	dev-cpp/catch:0
	dev-libs/boost:0
	dev-libs/crypto++:=
	dev-libs/libfmt:=
	media-libs/libsdl2
	media-video/ffmpeg"
RDEPEND="${DEPEND}"

PATCHES=("${FILESDIR}/001-hotkeys.patch")

#S="${WORKDIR}/${PN}-${MY_SHA}"

CMAKE_MAKEFILE_GENERATOR="emake"
CMAKE_BUILD_TYPE="Release"
BUILD_SHARED_LIBS="OFF"

src_configure() {
	local mycmakeargs=(
		-DBUILD_SHARED_LIBS=OFF
		-DENABLE_WEB_SERVICE=OFF
	)
	cmake_src_configure
}

pkg_postinst() {
	xdg_desktop_database_update
	xdg_mimeinfo_database_update
	xdg_icon_cache_update
}

pkg_postrm() {
	xdg_desktop_database_update
	xdg_mimeinfo_database_update
	xdg_icon_cache_update
}
