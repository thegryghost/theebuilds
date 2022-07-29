# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit cmake

DESCRIPTION="Nintendo Switch emulator"
HOMEPAGE="https://yuzu-emu.org/ https://github.com/yuzu-emu/yuzu-mainline"

MY_PV="mainline-${PV/./-}"

CUBEB_SHA="75d9d125ee655ef80f3bfcd97ae5a805931042b8"
VULKAN_HEADERS_SHA="33d4dd987fc8fc6475ff9ca2b4f0c3cc6e793337"
SDL_SHA="e2ade2bfc46d915cd306c63c830b81d800b2575f"
GOOGLETEST_SHA="800f5422ac9d9e0ad59cd860a2ef3a679588acb4"
MBEDTLS_SHA="8c88150ca139e06aa2aae8349df8292a88148ea1"
SPIRV_HEADERS_SHA="a3fdfe81465d57efc97cfd28ac6c8190fb31a6c8"
SIRIT_SHA="aa292d56650bc28f2b2d75973fab2e61d0136f9c"
XBYAK_SHA="c306b8e5786eeeb87b8925a8af5c3bf057ff5a90"
LIBRESSL_SHA="8929f818fd748fd31a34fec7c04558399e13014a"
SANITIZERS_CMAKE_SHA="aab6948fa863bc1cbe5d0850bc46b9ef02ed4c1a"
CPP_HTTPLIB_SHA="305a7abcb9b4e9e349843c6d563212e6c1bbbf21"
DYNARMIC_SHA="7f84870712ac2fe06aa62dc2bebbe46b51a2cc2e"
DISCORD_RPC_SHA="963aa9f3e5ce81a4682c6ca3d136cddda614db33"

SRC_URI="https://github.com/yuzu-emu/yuzu-mainline/archive/${MY_PV}.tar.gz -> ${P}.tar.gz
	https://github.com/kinetiknz/cubeb/archive/${CUBEB_SHA}.tar.gz -> ${PN}-cubeb-${CUBEB_SHA:0:7}.tar.gz
	https://github.com/KhronosGroup/Vulkan-Headers/archive/${VULKAN_HEADERS_SHA}.tar.gz -> ${PN}-Vulkan-Headers-${VULKAN_HEADERS_SHA:0:7}.tar.gz
	https://github.com/libsdl-org/SDL/archive/${SDL_SHA}.tar.gz -> ${PN}-SDL-${SDL_SHA:0:7}.tar.gz
	https://github.com/google/googletest/archive/${GOOGLETEST_SHA}.tar.gz -> ${PN}-googletest-${GOOGLETEST_SHA:0:7}.tar.gz
	https://github.com/yuzu-emu/mbedtls/archive/${MBEDTLS_SHA}.tar.gz -> ${PN}-mbedtls-${MBEDTLS_SHA:0:7}.tar.gz
	https://github.com/KhronosGroup/SPIRV-Headers/archive/${SPIRV_HEADERS_SHA}.tar.gz -> ${PN}-SPIRV-Headers-${SPIRV_HEADERS_SHA:0:7}.tar.gz
	https://github.com/ReinUsesLisp/sirit/archive/${SIRIT_SHA}.tar.gz -> ${PN}-sirit-${SIRIT_SHA:0:7}.tar.gz
	https://github.com/herumi/xbyak/archive/${XBYAK_SHA}.tar.gz -> ${PN}-xbyak-${XBYAK_SHA:0:7}.tar.gz
	https://github.com/citra-emu/ext-libressl-portable/archive/${LIBRESSL_SHA}.tar.gz -> ${PN}-libressl-${LIBRESSL_SHA:0:7}.tar.gz
	https://github.com/arsenm/sanitizers-cmake/archive/${SANITIZERS_CMAKE_SHA}.tar.gz -> ${PN}-sanitizers-cmake-${SANITIZERS_CMAKE_SHA:0:7}.tar.gz
	https://github.com/yhirose/cpp-httplib/archive/${CPP_HTTPLIB_SHA}.tar.gz -> ${PN}-cpp-httplib-${CPP_HTTPLIB_SHA:0:7}.tar.gz
	https://github.com/MerryMage/dynarmic/archive/${DYNARMIC_SHA}.tar.gz -> ${PN}-dynarmic-${DYNARMIC_SHA:0:7}.tar.gz
	https://github.com/discord/discord-rpc/archive/${DISCORD_RPC_SHA}.tar.gz -> ${PN}-discord-rpc-${DISCORD_RPC_SHA:0:7}.tar.gz
"

LICENSE="BSD GPL-2 GPL-2+ LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+compat-list +cubeb +web-service -discord"

DEPEND=">=app-arch/lz4-1.8
	app-eselect/eselect-yuzu
	>=app-arch/zstd-1.5
	dev-libs/boost:=[context]
	dev-libs/inih
	>=dev-libs/libfmt-8.0.1
	dev-libs/libzip
	dev-libs/openssl
	dev-qt/qtcore
	dev-qt/qtconcurrent
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

S="${WORKDIR}/${PN}-mainline-${MY_PV}"

PATCHES=(
	"${FILESDIR}/${PN}-0001-inih-SDLfix.patch"
	"${FILESDIR}/${PN}-0003-fix-INIReader.h-includes.patch"
)

src_prepare() {
	rm .gitmodules || die

	rmdir "${S}/externals/cubeb"
	mv "${WORKDIR}/cubeb-${CUBEB_SHA}" "${S}/externals/cubeb" || die
	rmdir "${S}/externals/Vulkan-Headers"
	mv "${WORKDIR}/Vulkan-Headers-${VULKAN_HEADERS_SHA}" "${S}/externals/Vulkan-Headers" || die
	rmdir "${S}/externals/SDL"
	mv "${WORKDIR}/SDL-${SDL_SHA}" "${S}/externals/SDL" || die
	rmdir "${S}/externals/mbedtls"
	mv "${WORKDIR}/mbedtls-${MBEDTLS_SHA}" "${S}/externals/mbedtls" || die
	rmdir "${S}/externals/sirit"
	mv "${WORKDIR}/sirit-${SIRIT_SHA}" "${S}/externals/sirit" || die
	rmdir "${S}/externals/xbyak"
	mv "${WORKDIR}/xbyak-${XBYAK_SHA}" "${S}/externals/xbyak" || die
	rmdir "${S}/externals/libressl"
	mv "${WORKDIR}/ext-libressl-portable-${LIBRESSL_SHA}" "${S}/externals/libressl" || die
	rmdir "${S}/externals/cpp-httplib"
	mv "${WORKDIR}/cpp-httplib-${CPP_HTTPLIB_SHA}" "${S}/externals/cpp-httplib" || die
	rmdir "${S}/externals/dynarmic"
	mv "${WORKDIR}/dynarmic-${DYNARMIC_SHA}" "${S}/externals/dynarmic" || die
	rmdir "${S}/externals/discord-rpc"
	mv "${WORKDIR}/discord-rpc-${DISCORD_RPC_SHA}" "${S}/externals/discord-rpc" || die
	rmdir "${S}/externals/cubeb/googletest"
	mv "${WORKDIR}/googletest-${GOOGLETEST_SHA}" "${S}/externals/cubeb/googletest" || die
	rmdir "${S}/externals/sirit/externals/SPIRV-Headers"
	mv "${WORKDIR}/SPIRV-Headers-${SPIRV_HEADERS_SHA}" "${S}/externals/sirit/externals/SPIRV-Headers" || die
	rmdir "${S}/externals/cubeb/cmake/sanitizers-cmake"
	mv "${WORKDIR}/sanitizers-cmake-${SANITIZERS_CMAKE_SHA}" "${S}/externals/cubeb/cmake/sanitizers-cmake" || die
	sed -e 's/-Werror=uninitialized/#-Werror=uninitialized/g' -i src/CMakeLists.txt
	cmake_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DBUILD_FULLNAME="${MY_PV}"
		-DBUILD_SHARED_LIBS=OFF
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
		-DYUZU_USE_QT_WEB_ENGINE=OFF
		-DYUZU_ENABLE_COMPATIBILITY_REPORTING=ON
		-DYUZU_CONAN_INSTALLED=OFF
	)
        cmake_src_configure
}

src_install() {
	cmake_src_install
	rm -rf "${D}/usr/include" "${D}/usr/share/cmake" "${D}/usr/lib64"
	mv "${D}/usr/bin/yuzu" "${D}/usr/bin/yuzu-mainline"
	mv "${D}/usr/bin/yuzu-cmd" "${D}/usr/bin/yuzu-cmd-mainline"
}

pkg_postinst() {
	xdg_mimeinfo_database_update
	xdg_desktop_database_update
	eselect yuzu update ifunset
}

pkg_postrm() {
	xdg_mimeinfo_database_update
	xdg_desktop_database_update
	eselect yuzu update ifunset
}


