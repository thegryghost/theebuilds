# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit cmake

DESCRIPTION="Nintendo Switch emulator"
HOMEPAGE="https://yuzu-emu.org/ https://github.com/yuzu-emu/yuzu-mainline"

MY_PV="mainline-${PV/./-}"

SDL_SHA="e2ade2bfc46d915cd306c63c830b81d800b2575f"
VULKAN_HEADERS_SHA="e005e1f8175d006adc3676b40ac3dd2212961a68"
CPP_HTTPLIB_SHA="9648f950f5a8a41d18833cf4a85f5821b1bcac54"
CUBEB_SHA="75d9d125ee655ef80f3bfcd97ae5a805931042b8"
DISCORD_RPC_SHA="963aa9f3e5ce81a4682c6ca3d136cddda614db33"
DYNARMIC_SHA="af2d50288fc537201014c4230bb55ab9018a7438"
FFMPEG_SHA="dc91b913b6260e85e1304c74ff7bb3c22a8c9fb1"
INIH_SHA="1e80a47dffbda813604f0913e2ad68c7054c14e4"
LIBRESSL_SHA="8289d0d07de6553bf4b900bf60e808ea3f7f59da"
LIBUSB_SHA="c6a35c56016ea2ab2f19115d2ea1e85e0edae155"
MBEDTLS_SHA="8c88150ca139e06aa2aae8349df8292a88148ea1"
OPUS_SHA="ad8fe90db79b7d2a135e3dfd2ed6631b0c5662ab"
SIRIT_SHA="a39596358a3a5488c06554c0c15184a6af71e433"
XBYAK_SHA="c306b8e5786eeeb87b8925a8af5c3bf057ff5a90"
SIRIT_SPIRV_HEADERS_SHA="a3fdfe81465d57efc97cfd28ac6c8190fb31a6c8"

SRC_URI="https://github.com/yuzu-emu/yuzu-mainline/archive/${MY_PV}.tar.gz -> ${P}.tar.gz
        https://github.com/libsdl-org/SDL/archive/${SDL_SHA}.tar.gz -> ${PN}-SDL-${SDL_SHA:0:7}.tar.gz
        https://github.com/KhronosGroup/Vulkan-Headers/archive/${VULKAN_HEADERS_SHA}.tar.gz -> ${PN}-Vulkan-Headers-${VULKAN_HEADERS_SHA:0:7}.tar.gz
        https://github.com/yhirose/cpp-httplib/archive/${CPP_HTTPLIB_SHA}.tar.gz -> ${PN}-cpp-httplib-${CPP_HTTPLIB_SHA:0:7}.tar.gz
        https://github.com/kinetiknz/cubeb/archive/${CUBEB_SHA}.tar.gz -> ${PN}-cubeb-${CUBEB_SHA:0:7}.tar.gz
        https://github.com/discord/discord-rpc/archive/${DISCORD_RPC_SHA}.tar.gz -> ${PN}-discord-rpc-${DISCORD_RPC_SHA:0:7}.tar.gz
        https://github.com/MerryMage/dynarmic/archive/${DYNARMIC_SHA}.tar.gz -> ${PN}-dynarmic-${DYNARMIC_SHA:0:7}.tar.gz
        https://github.com/benhoyt/inih/archive/${INIH_SHA}.tar.gz -> ${PN}-inih-${INIH_SHA:0:7}.tar.gz
        https://github.com/citra-emu/ext-libressl-portable/archive/${LIBRESSL_SHA}.tar.gz -> ${PN}-libressl-${LIBRESSL_SHA:0:7}.tar.gz
        https://github.com/libusb/libusb/archive/${LIBUSB_SHA}.tar.gz -> ${PN}-libusb-${LIBUSB_SHA:0:7}.tar.gz
        https://github.com/yuzu-emu/mbedtls/archive/${MBEDTLS_SHA}.tar.gz -> ${PN}-mbedtls-${MBEDTLS_SHA:0:7}.tar.gz
        https://github.com/xiph/opus/archive/${OPUS_SHA}.tar.gz -> ${PN}-opus-${OPUS_SHA:0:7}.tar.gz
        https://github.com/ReinUsesLisp/sirit/archive/${SIRIT_SHA}.tar.gz -> ${PN}-sirit-${SIRIT_SHA:0:7}.tar.gz
        https://github.com/herumi/xbyak/archive/${XBYAK_SHA}.tar.gz -> ${PN}-xbyak-${XBYAK_SHA:0:7}.tar.gz
	https://github.com/KhronosGroup/SPIRV-Headers/archive/${SIRIT_SPIRV_HEADERS_SHA}.tar.gz -> ${PN}-sirit-spirv-headers-${SIRIT_SPIRV_HEADERS_SHA:0:7}.tar.gz
"
LICENSE="BSD GPL-2 GPL-2+ LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+compat-list +cubeb +web-service"

#	cubeb? ( dev-libs/cubeb )

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
	media-libs/libsdl2
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


#PATCHES=(
#	"${FILESDIR}/${PN}-0001-Allow-use-of-system-Opus-and-inih.patch"
#	"${FILESDIR}/${PN}-0003-fix-INIReader.h-includes.patch"
#	"${FILESDIR}/${PN}-0004-minimalise-finding-Boost-components.patch"
#	"${FILESDIR}/${PN}-0006-Allow-system-cubeb.patch"
#)

PATCHES=(
	"${FILESDIR}/${PN}-0001-Allow-use-of-system-Opus-and-inih.patch"
	"${FILESDIR}/${PN}-0003-fix-INIReader.h-includes.patch"
	"${FILESDIR}/cmake_no_conan.patch"
)
src_prepare() {
	rm .gitmodules || die
	rmdir "${S}/externals/"{cpp-httplib,cubeb,discord-rpc,dynarmic,libressl,mbedtls,SDL,sirit,Vulkan-Headers,xbyak} || die

	mv "${WORKDIR}/cpp-httplib-${CPP_HTTPLIB_SHA}" "${S}/externals/cpp-httplib" || die
	mv "${WORKDIR}/cubeb-${CUBEB_SHA}" "${S}/externals/cubeb" || die
	mv "${WORKDIR}/discord-rpc-${DISCORD_RPC_SHA}" "${S}/externals/discord-rpc" || die
	mv "${WORKDIR}/dynarmic-${DYNARMIC_SHA}" "${S}/externals/dynarmic" || die
	mv "${WORKDIR}/ext-libressl-portable-${LIBRESSL_SHA}" "${S}/externals/libressl" || die
	mv "${WORKDIR}/mbedtls-${MBEDTLS_SHA}" "${S}/externals/mbedtls" || die
	mv "${WORKDIR}/SDL-${SDL_SHA}" "${S}/externals/SDL" || die
	rm -rf "${WORKDIR}/sirit-${SIRIT_SHA}/externals/SPIRV-Headers"
	mv "${WORKDIR}/SPIRV-Headers-${SIRIT_SPIRV_HEADERS_SHA}" "${WORKDIR}/sirit-${SIRIT_SHA}/externals/SPIRV-Headers" || die
	mv "${WORKDIR}/sirit-${SIRIT_SHA}" "${S}/externals/sirit" || die
	mv "${WORKDIR}/Vulkan-Headers-${VULKAN_HEADERS_SHA}" "${S}/externals/Vulkan-Headers" || die
	mv "${WORKDIR}/xbyak-${XBYAK_SHA}" "${S}/externals/xbyak" || die
	rm -rf "${S}/externals/opus" || die
	mv "${WORKDIR}/opus-${OPUS_SHA}" "${S}/externals/opus" || die
#	mv "${WORKDIR}/-${}" "${S}/externals/" || die
#	mv "${WORKDIR}/-${}" "${S}/externals/" || die
#	mv "${WORKDIR}/-${}" "${S}/externals/" || die

#	sed -e 's/find_package(Boost .*/find_package(Boost 1.71 COMPONENTS context REQUIRED)/' -i src/common/CMakeLists.txt || die

#	rmdir "${WORKDIR}/sirit-${SIRIT_SHA}/externals/SPIRV-Headers" || die
#	rmdir "${S}/externals/"{dynarmic,sirit,mbedtls} || die
	cmake_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DBUILD_FULLNAME=""
		-DBUILD_FULLNAME="${MY_PV}"
		-DBUILD_SHARED_LIBS=OFF
		-DENABLE_COMPATIBILITY_LIST_DOWNLOAD=$(usex compat-list)
#		-DENABLE_CUBEB=$(usex cubeb)
		-DENABLE_CUBEB=OFF
		-DENABLE_WEB_SERVICE=OFF
		-DGIT_BRANCH="${PN}"
		-DGIT_DESC="${PV}"
		-DGIT_REV="${PV}"
		-DUSE_DISCORD_PRESENCE=OFF
#		-DUSE_SYSTEM_CUBEB=$(usex cubeb)
		-DUSE_SYSTEM_INIH=ON
		-DUSE_SYSTEM_OPUS=ON
		-DYUZU_USE_BUNDLED_OPUS=OFF
		-DYUZU_ENABLE_COMPATIBILITY_REPORTING=ON
		-DYUZU_USE_BUNDLED_BOOST=OFF
		-DYUZU_USE_QT_WEB_ENGINE=OFF
		-DUSE_SANITIZERS=NO
		-DBUILD_TESTS=NO
	)
	cmake_src_configure
}
