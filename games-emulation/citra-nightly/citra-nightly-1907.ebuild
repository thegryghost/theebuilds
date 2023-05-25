# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit cmake

DESCRIPTION="Nintendo 3DS Emulator"
HOMEPAGE="https://github.com/citra-emu/citra-nightly"


CATCH2_SHA="3f0283de7a9c43200033da996ff9093be3ac84dc"
CUBEB_SHA="dc511c6b3597b6384d28949285b9289e009830ea"
CRYPTOPP_SHA="511806c0eba8ba5b5cedd4b4a814e96df92864a6"
DDS_KTX_SHA="42dd8aa6ded90b1ec06091522774feff51e83fc5"
OPENAL_SOFT_SHA="d9fed51aa6391debc31dbbca550f055c980afe70"
FMT_SHA="a33701196adfad74917046096bf5a2aa0ab0bb50"
LODEPNG_SHA="18964554bc769255401942e0e6dfd09f2fab2093"
GOOGLETEST_SHA="800f5422ac9d9e0ad59cd860a2ef3a679588acb4"
LIBYUV_SHA="6900494d90ae095d44405cd4cc3f346971fa69c9"
ZSTD_SHA="63779c798237346c2b245c546c40b72a5a5913fe"
SDL2_SHA="ac13ca9ab691e13e8eebe9684740ddcb0d716203"
NIHSTRO_SHA="fd69de1a1b960ec296cc67d32257b0f9e2d89ac6"
CRYPTOPP_CMAKE_SHA="15798ac9c2611d5c7f9ba832e2c9159bdd8945f2"
ENET_SHA="4f8e9bdc4ce6d1f61a6274b0e557065a38190952"
BOOST_SHA="80a171a179c1f901e4f8dfc8962417f44865ceec"
XBYAK_SHA="a1ac3750f9a639b5a6c6d6c7da4259b8d6790989"
CPP_JWT_SHA="e12ef06218596b52d9b5d6e1639484866a8e7067"
LIBRESSL_SHA="8929f818fd748fd31a34fec7c04558399e13014a"
SANITIZERS_CMAKE_SHA="aab6948fa863bc1cbe5d0850bc46b9ef02ed4c1a"
SOUNDTOUCH_SHA="dd2252e9af3f2d6b749378173a4ae89551e06faf"
TEAKRA_SHA="01db7cdd00aabcce559a8dddce8798dabb71949b"
DYNARMIC_SHA="d5c2b473a831ca9e2a93bda30dc131b4fee7314f"
DISCORD_RPC_SHA="963aa9f3e5ce81a4682c6ca3d136cddda614db33"

SRC_URI="https://github.com/citra-emu/citra-nightly/archive/refs/tags/nightly-${PV}.tar.gz -> ${P}.tar.gz
	https://github.com/catchorg/Catch2/archive/${CATCH2_SHA}.tar.gz -> ${PN}-catch2-${CATCH2_SHA:0:7}.tar.gz
	https://github.com/mozilla/cubeb/archive/${CUBEB_SHA}.tar.gz -> ${PN}-cubeb-${CUBEB_SHA:0:7}.tar.gz
	https://github.com/weidai11/cryptopp/archive/${CRYPTOPP_SHA}.tar.gz -> ${PN}-cryptopp-${CRYPTOPP_SHA:0:7}.tar.gz
	https://github.com/septag/dds-ktx/archive/${DDS_KTX_SHA}.tar.gz -> ${PN}-dds-ktx-${DDS_KTX_SHA:0:7}.tar.gz
	https://github.com/kcat/openal-soft/archive/${OPENAL_SOFT_SHA}.tar.gz -> ${PN}-openal-soft-${OPENAL_SOFT_SHA:0:7}.tar.gz
	https://github.com/fmtlib/fmt/archive/${FMT_SHA}.tar.gz -> ${PN}-fmt-${FMT_SHA:0:7}.tar.gz
	https://github.com/lvandeve/lodepng/archive/${LODEPNG_SHA}.tar.gz -> ${PN}-lodepng-${LODEPNG_SHA:0:7}.tar.gz
	https://github.com/google/googletest/archive/${GOOGLETEST_SHA}.tar.gz -> ${PN}-googletest-${GOOGLETEST_SHA:0:7}.tar.gz
	https://github.com/lemenkov/libyuv/archive/${LIBYUV_SHA}.tar.gz -> ${PN}-libyuv-${LIBYUV_SHA:0:7}.tar.gz
	https://github.com/facebook/zstd/archive/${ZSTD_SHA}.tar.gz -> ${PN}-zstd-${ZSTD_SHA:0:7}.tar.gz
	https://github.com/libsdl-org/SDL/archive/${SDL2_SHA}.tar.gz -> ${PN}-sdl2-${SDL2_SHA:0:7}.tar.gz
	https://github.com/neobrain/nihstro/archive/${NIHSTRO_SHA}.tar.gz -> ${PN}-nihstro-${NIHSTRO_SHA:0:7}.tar.gz
	https://github.com/abdes/cryptopp-cmake/archive/${CRYPTOPP_CMAKE_SHA}.tar.gz -> ${PN}-cryptopp-cmake-${CRYPTOPP_CMAKE_SHA:0:7}.tar.gz
	https://github.com/lsalzman/enet/archive/${ENET_SHA}.tar.gz -> ${PN}-enet-${ENET_SHA:0:7}.tar.gz
	https://github.com/citra-emu/ext-boost/archive/${BOOST_SHA}.tar.gz -> ${PN}-boost-${BOOST_SHA:0:7}.tar.gz
	https://github.com/herumi/xbyak/archive/${XBYAK_SHA}.tar.gz -> ${PN}-xbyak-${XBYAK_SHA:0:7}.tar.gz
	https://github.com/arun11299/cpp-jwt/archive/${CPP_JWT_SHA}.tar.gz -> ${PN}-cpp-jwt-${CPP_JWT_SHA:0:7}.tar.gz
	https://github.com/citra-emu/ext-libressl-portable/archive/${LIBRESSL_SHA}.tar.gz -> ${PN}-libressl-${LIBRESSL_SHA:0:7}.tar.gz
	https://github.com/arsenm/sanitizers-cmake/archive/${SANITIZERS_CMAKE_SHA}.tar.gz -> ${PN}-sanitizers-cmake-${SANITIZERS_CMAKE_SHA:0:7}.tar.gz
	https://codeberg.org/soundtouch/soundtouch/archive/${SOUNDTOUCH_SHA}.tar.gz -> ${PN}-soundtouch-${SOUNDTOUCH_SHA:0:7}.tar.gz
	https://github.com/wwylele/teakra/archive/${TEAKRA_SHA}.tar.gz -> ${PN}-teakra-${TEAKRA_SHA:0:7}.tar.gz
	https://github.com/merryhime/dynarmic/archive/${DYNARMIC_SHA}.tar.gz -> ${PN}-dynarmic-${DYNARMIC_SHA:0:7}.tar.gz
	https://github.com/discord/discord-rpc/archive/${DISCORD_RPC_SHA}.tar.gz -> ${PN}-discord-rpc-${DISCORD_RPC_SHA:0:7}.tar.gz
"

LICENSE="BSD GPL-2 GPL-2+ LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+compat-list +cubeb +web-service -discord"

DEPEND=">=app-arch/zstd-1.5
	dev-libs/boost:=[context]
	dev-libs/inih
	>=dev-libs/libfmt-8.0.1
	dev-libs/libzip
	>=dev-libs/openssl-1.1
	media-libs/libsdl2
	dev-qt/qtgui
	dev-qt/qtcore
	dev-qt/qtmultimedia
	dev-qt/qtnetwork
	dev-qt/qtopengl
	dev-qt/qtwidgets
	dev-libs/crypto++
	app-eselect/eselect-citra
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

S="${WORKDIR}/${PN}-nightly-${PV}"


PATCHES=(
	"${FILESDIR}/001-hotkeys.patch"
	"${FILESDIR}/cmake.patch"
	"${FILESDIR}/citra-inih1.patch"
)

src_prepare() {
	rm .gitmodules || die

	rmdir "${S}/externals/catch2"
	if [ ! -e "${WORKDIR}/Catch2-${CATCH2_SHA}" ]; then
		mv "${WORKDIR}/Catch2" "${S}/externals/catch2" || die
	else
		mv "${WORKDIR}/Catch2-${CATCH2_SHA}" "${S}/externals/catch2" || die
	fi
	rmdir "${S}/externals/cubeb"
	if [ ! -e "${WORKDIR}/cubeb-${CUBEB_SHA}" ]; then
		mv "${WORKDIR}/cubeb" "${S}/externals/cubeb" || die
	else
		mv "${WORKDIR}/cubeb-${CUBEB_SHA}" "${S}/externals/cubeb" || die
	fi
	rmdir "${S}/externals/cryptopp"
	if [ ! -e "${WORKDIR}/cryptopp-${CRYPTOPP_SHA}" ]; then
		mv "${WORKDIR}/cryptopp" "${S}/externals/cryptopp" || die
	else
		mv "${WORKDIR}/cryptopp-${CRYPTOPP_SHA}" "${S}/externals/cryptopp" || die
	fi
	rmdir "${S}/externals/dds-ktx"
	if [ ! -e "${WORKDIR}/dds-ktx-${DDS_KTX_SHA}" ]; then
		mv "${WORKDIR}/dds-ktx" "${S}/externals/dds-ktx" || die
	else
		mv "${WORKDIR}/dds-ktx-${DDS_KTX_SHA}" "${S}/externals/dds-ktx" || die
	fi
	rmdir "${S}/externals/openal-soft"
	if [ ! -e "${WORKDIR}/openal-soft-${OPENAL_SOFT_SHA}" ]; then
		mv "${WORKDIR}/openal-soft" "${S}/externals/openal-soft" || die
	else
		mv "${WORKDIR}/openal-soft-${OPENAL_SOFT_SHA}" "${S}/externals/openal-soft" || die
	fi
	rmdir "${S}/externals/fmt"
	if [ ! -e "${WORKDIR}/fmt-${FMT_SHA}" ]; then
		mv "${WORKDIR}/fmt" "${S}/externals/fmt" || die
	else
		mv "${WORKDIR}/fmt-${FMT_SHA}" "${S}/externals/fmt" || die
	fi
	rmdir "${S}/externals/lodepng/lodepng"
	if [ ! -e "${WORKDIR}/lodepng-${LODEPNG_SHA}" ]; then
		mv "${WORKDIR}/lodepng" "${S}/externals/lodepng/lodepng" || die
	else
		mv "${WORKDIR}/lodepng-${LODEPNG_SHA}" "${S}/externals/lodepng/lodepng" || die
	fi
	rmdir "${S}/externals/libyuv"
	if [ ! -e "${WORKDIR}/libyuv-${LIBYUV_SHA}" ]; then
		mv "${WORKDIR}/libyuv" "${S}/externals/libyuv" || die
	else
		mv "${WORKDIR}/libyuv-${LIBYUV_SHA}" "${S}/externals/libyuv" || die
	fi
	rmdir "${S}/externals/zstd"
	if [ ! -e "${WORKDIR}/zstd-${ZSTD_SHA}" ]; then
		mv "${WORKDIR}/zstd" "${S}/externals/zstd" || die
	else
		mv "${WORKDIR}/zstd-${ZSTD_SHA}" "${S}/externals/zstd" || die
	fi
	rmdir "${S}/externals/sdl2/SDL"
	if [ ! -e "${WORKDIR}/SDL-${SDL2_SHA}" ]; then
		mv "${WORKDIR}/SDL" "${S}/externals/sdl2/SDL" || die
	else
		mv "${WORKDIR}/SDL-${SDL2_SHA}" "${S}/externals/sdl2/SDL" || die
	fi
	rmdir "${S}/externals/nihstro"
	if [ ! -e "${WORKDIR}/nihstro-${NIHSTRO_SHA}" ]; then
		mv "${WORKDIR}/nihstro" "${S}/externals/nihstro" || die
	else
		mv "${WORKDIR}/nihstro-${NIHSTRO_SHA}" "${S}/externals/nihstro" || die
	fi
	rmdir "${S}/externals/cryptopp-cmake"
	if [ ! -e "${WORKDIR}/cryptopp-cmake-${CRYPTOPP_CMAKE_SHA}" ]; then
		mv "${WORKDIR}/cryptopp-cmake" "${S}/externals/cryptopp-cmake" || die
	else
		mv "${WORKDIR}/cryptopp-cmake-${CRYPTOPP_CMAKE_SHA}" "${S}/externals/cryptopp-cmake" || die
	fi
	rmdir "${S}/externals/enet"
	if [ ! -e "${WORKDIR}/enet-${ENET_SHA}" ]; then
		mv "${WORKDIR}/enet" "${S}/externals/enet" || die
	else
		mv "${WORKDIR}/enet-${ENET_SHA}" "${S}/externals/enet" || die
	fi
	rmdir "${S}/externals/boost"
	if [ ! -e "${WORKDIR}/ext-boost-${BOOST_SHA}" ]; then
		mv "${WORKDIR}/ext-boost" "${S}/externals/boost" || die
	else
		mv "${WORKDIR}/ext-boost-${BOOST_SHA}" "${S}/externals/boost" || die
	fi
	rmdir "${S}/externals/xbyak"
	if [ ! -e "${WORKDIR}/xbyak-${XBYAK_SHA}" ]; then
		mv "${WORKDIR}/xbyak" "${S}/externals/xbyak" || die
	else
		mv "${WORKDIR}/xbyak-${XBYAK_SHA}" "${S}/externals/xbyak" || die
	fi
	rmdir "${S}/externals/cpp-jwt"
	if [ ! -e "${WORKDIR}/cpp-jwt-${CPP_JWT_SHA}" ]; then
		mv "${WORKDIR}/cpp-jwt" "${S}/externals/cpp-jwt" || die
	else
		mv "${WORKDIR}/cpp-jwt-${CPP_JWT_SHA}" "${S}/externals/cpp-jwt" || die
	fi
	rmdir "${S}/externals/libressl"
	if [ ! -e "${WORKDIR}/ext-libressl-portable-${LIBRESSL_SHA}" ]; then
		mv "${WORKDIR}/ext-libressl-portable" "${S}/externals/libressl" || die
	else
		mv "${WORKDIR}/ext-libressl-portable-${LIBRESSL_SHA}" "${S}/externals/libressl" || die
	fi
	rmdir "${S}/externals/soundtouch"
	if [ ! -e "${WORKDIR}/soundtouch-${SOUNDTOUCH_SHA}" ]; then
		mv "${WORKDIR}/soundtouch" "${S}/externals/soundtouch" || die
	else
		mv "${WORKDIR}/soundtouch-${SOUNDTOUCH_SHA}" "${S}/externals/soundtouch" || die
	fi
	rmdir "${S}/externals/teakra"
	if [ ! -e "${WORKDIR}/teakra-${TEAKRA_SHA}" ]; then
		mv "${WORKDIR}/teakra" "${S}/externals/teakra" || die
	else
		mv "${WORKDIR}/teakra-${TEAKRA_SHA}" "${S}/externals/teakra" || die
	fi
	rmdir "${S}/externals/dynarmic"
	if [ ! -e "${WORKDIR}/dynarmic-${DYNARMIC_SHA}" ]; then
		mv "${WORKDIR}/dynarmic" "${S}/externals/dynarmic" || die
	else
		mv "${WORKDIR}/dynarmic-${DYNARMIC_SHA}" "${S}/externals/dynarmic" || die
	fi
	rmdir "${S}/externals/discord-rpc"
	if [ ! -e "${WORKDIR}/discord-rpc-${DISCORD_RPC_SHA}" ]; then
		mv "${WORKDIR}/discord-rpc" "${S}/externals/discord-rpc" || die
	else
		mv "${WORKDIR}/discord-rpc-${DISCORD_RPC_SHA}" "${S}/externals/discord-rpc" || die
	fi
	rmdir "${S}/externals/cubeb/googletest"
	if [ ! -e "${WORKDIR}/googletest-${GOOGLETEST_SHA}" ]; then
		mv "${WORKDIR}/googletest" "${S}/externals/cubeb/googletest" || die
	else
		mv "${WORKDIR}/googletest-${GOOGLETEST_SHA}" "${S}/externals/cubeb/googletest" || die
	fi
	rmdir "${S}/externals/cubeb/cmake/sanitizers-cmake"
	if [ ! -e "${WORKDIR}/sanitizers-cmake-${SANITIZERS_CMAKE_SHA}" ]; then
		mv "${WORKDIR}/sanitizers-cmake" "${S}/externals/cubeb/cmake/sanitizers-cmake" || die
	else
		mv "${WORKDIR}/sanitizers-cmake-${SANITIZERS_CMAKE_SHA}" "${S}/externals/cubeb/cmake/sanitizers-cmake" || die
	fi
	cmake_src_prepare
}

CMAKE_BUILD_TYPE="Release"
BUILD_SHARED_LIBS="OFF"

src_configure() {
	local mycmakeargs=(
		-DGIT_BRANCH="${PN}"
		-DGIT_DESC="${PV}"
		-DBUILD_SHARED_LIBS=OFF
		-DENABLE_COMPATIBILITY_LIST_DOWNLOAD=$(usex compat-list)
		-DENABLE_QT=ON
		-DENABLE_QT_TRANSLATION=OFF
		-DENABLE_WEB_SERVICE=$(usex web-service)
		-DENABLE_CUBEB=$(usex cubeb)
		-DCITRA_USE_BUNDLED_FFMPEG=OFF
		-DCOMPILE_WITH_DWARF=OFF
		-DUSE_SYSTEM_BOOST=ON
		-DUSE_DISCORD_PRESENCE=$(usex discord)
		-DCITRA_USE_BUNDLED_SDL2=OFF
		-DCITRA_USE_BUNDLED_QT=OFF
		-DCITRA_USE_BUNDLED_FFMPEG=OFF
		-DUSE_SYSTEM_INIH=ON
	)
	cmake_src_configure
}

pkg_postinst() {
	xdg_mimeinfo_database_update
	xdg_desktop_database_update
	eselect citra update ifunset
}

pkg_postrm() {
	xdg_mimeinfo_database_update
	xdg_desktop_database_update
	eselect citra update ifunset
}

src_install() {
	cmake_src_install
	rm -rf  "${D}/usr/include" "${D}/usr/lib64"
	mv "${D}/usr/bin/citra" "${D}/usr/bin/citra-nightly"
	mv "${D}/usr/bin/citra-qt" "${D}/usr/bin/citra-qt-nightly"
	mv "${D}/usr/bin/citra-room" "${D}/usr/bin/citra-room-nightly"
}


