# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit cmake

DESCRIPTION="Nintendo Switch emulator (Early Access)"
HOMEPAGE="https://github.com/pineappleEA/pineapple-src/releases"

SRC_URI="https://github.com/pineappleEA/pineapple-src/archive/refs/tags/EA-${PV}.tar.gz"

S="${WORKDIR}/pineapple-src-EA-${PV}"

LICENSE="BSD GPL-2 GPL-2+ LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+compat-list +cubeb +web-service -discord"

DEPEND=">=app-arch/lz4-1.8
	>=app-arch/zstd-1.5
	dev-libs/boost:=[context]
	dev-libs/inih
	>=dev-libs/libfmt-8.0.1
	dev-libs/libzip
	dev-libs/openssl
	dev-qt/qtcore
	dev-qt/qtgui
	dev-qt/qtwidgets
	>=media-libs/opus-1.3
	media-video/ffmpeg
	>=sys-libs/zlib-1.2
	>=dev-cpp/nlohmann_json-3.8
	virtual/libusb:="

RDEPEND="${DEPEND}
	app-arch/zstd
	media-libs/vulkan-loader"

BDEPEND="dev-cpp/catch
	dev-cpp/nlohmann_json
	dev-util/vulkan-headers"

PATCHES=( "${FILESDIR}/inih.patch" )

CMAKE_BUILD_TYPE="Release"

src_prepare() {
        rm -rf "${S}/externals/"{ffmpeg,inih,opus,libusb} || die
        cmake_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DBUILD_FULLNAME="${PV}"
		-DBUILD_SHARED_LIBS=OFF
		-DCMAKE_BUILD_TYPE=Release
		-DENABLE_COMPATIBILITY_LIST_DOWNLOAD=$(usex compat-list)
		-DENABLE_CUBEB=$(usex cubeb)
		-DYUZU_USE_EXTERNAL_SDL2=ON
		-DENABLE_WEB_SERVICE=$(usex web-service)
		-DGIT_BRANCH="${PN}"
		-DGIT_DESC="${PV}"
		-DGIT_REV="${PV}"
		-DUSE_DISCORD_PRESENCE=$(usex discord)
		-DUSE_SYSTEM_INIH=ON
		-DYUZU_USE_BUNDLED_OPUS=OFF
		-DYUZU_USE_BUNDLED_BOOST=OFF
		-DYUZU_USE_QT_WEB_ENGINE=OFF
		-DYUZU_ENABLE_COMPATIBILITY_REPORTING=ON
		-DYUZU_CONAN_INSTALLED=OFF
	)
        cmake_src_configure
}

pkg_postinst() {
        xdg_mimeinfo_database_update
        xdg_desktop_database_update
}

pkg_postrm() {
        xdg_mimeinfo_database_update
        xdg_desktop_database_update
}


