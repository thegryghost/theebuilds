# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit cmake

DESCRIPTION="Nintendo 3DS Emulator"
HOMEPAGE="https://github.com/citra-emu/citra-nightly"


CATCH2_SHA="dc001fa935d71b4b77f263fce405c9dbdfcbfe28"
CUBEB_SHA="dc511c6b3597b6384d28949285b9289e009830ea"
CRYPTOPP_SHA="511806c0eba8ba5b5cedd4b4a814e96df92864a6"
FMT_SHA="a33701196adfad74917046096bf5a2aa0ab0bb50"
LODEPNG_SHA="18964554bc769255401942e0e6dfd09f2fab2093"
GOOGLETEST_SHA="800f5422ac9d9e0ad59cd860a2ef3a679588acb4"
LIBYUV_SHA="6900494d90ae095d44405cd4cc3f346971fa69c9"
ZSTD_SHA="e47e674cd09583ff0503f0f6defd6d23d8b718d3"
SDL2_SHA="a1d1946dcba6509f0679f507b57e7b228d32e6f8"
NIHSTRO_SHA="fd69de1a1b960ec296cc67d32257b0f9e2d89ac6"
CRYPTOPP_CMAKE_SHA="15798ac9c2611d5c7f9ba832e2c9159bdd8945f2"
ENET_SHA="4f8e9bdc4ce6d1f61a6274b0e557065a38190952"
BOOST_SHA="80a171a179c1f901e4f8dfc8962417f44865ceec"
XBYAK_SHA="a1ac3750f9a639b5a6c6d6c7da4259b8d6790989"
CPP_JWT_SHA="e12ef06218596b52d9b5d6e1639484866a8e7067"
LIBRESSL_SHA="8929f818fd748fd31a34fec7c04558399e13014a"
SANITIZERS_CMAKE_SHA="aab6948fa863bc1cbe5d0850bc46b9ef02ed4c1a"
SOUNDTOUCH_SHA="060181eaf273180d3a7e87349895bd0cb6ccbf4a"
TEAKRA_SHA="01db7cdd00aabcce559a8dddce8798dabb71949b"
DYNARMIC_SHA="c08c5a9362bb224dc343c2f616c24df027dfdf13"
DISCORD_RPC_SHA="963aa9f3e5ce81a4682c6ca3d136cddda614db33"

SRC_URI="https://github.com/citra-emu/citra-nightly/archive/refs/tags/nightly-${PV}.tar.gz -> ${P}.tar.gz
	https://github.com/catchorg/Catch2/archive/${CATCH2_SHA}.tar.gz -> ${PN}-catch2-${CATCH2_SHA:0:7}.tar.gz
	https://github.com/mozilla/cubeb/archive/${CUBEB_SHA}.tar.gz -> ${PN}-cubeb-${CUBEB_SHA:0:7}.tar.gz
	https://github.com/weidai11/cryptopp/archive/${CRYPTOPP_SHA}.tar.gz -> ${PN}-cryptopp-${CRYPTOPP_SHA:0:7}.tar.gz
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
	https://github.com/citra-emu/ext-soundtouch/archive/${SOUNDTOUCH_SHA}.tar.gz -> ${PN}-soundtouch-${SOUNDTOUCH_SHA:0:7}.tar.gz
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
	"${FILESDIR}/citra-inih.patch"
)

src_prepare() {
	rm .gitmodules || die

	rmdir "${S}/externals/catch2"
	mv "${WORKDIR}/Catch2-${CATCH2_SHA}" "${S}/externals/catch2" || die
	rmdir "${S}/externals/cubeb"
	mv "${WORKDIR}/cubeb-${CUBEB_SHA}" "${S}/externals/cubeb" || die
	rmdir "${S}/externals/cryptopp"
	mv "${WORKDIR}/cryptopp-${CRYPTOPP_SHA}" "${S}/externals/cryptopp" || die
	rmdir "${S}/externals/fmt"
	mv "${WORKDIR}/fmt-${FMT_SHA}" "${S}/externals/fmt" || die
	rmdir "${S}/externals/lodepng/lodepng"
	mv "${WORKDIR}/lodepng-${LODEPNG_SHA}" "${S}/externals/lodepng/lodepng" || die
	rmdir "${S}/externals/libyuv"
	mv "${WORKDIR}/libyuv-${LIBYUV_SHA}" "${S}/externals/libyuv" || die
	rmdir "${S}/externals/zstd"
	mv "${WORKDIR}/zstd-${ZSTD_SHA}" "${S}/externals/zstd" || die
	rmdir "${S}/externals/sdl2/SDL"
	mv "${WORKDIR}/SDL-${SDL2_SHA}" "${S}/externals/sdl2/SDL" || die
	rmdir "${S}/externals/nihstro"
	mv "${WORKDIR}/nihstro-${NIHSTRO_SHA}" "${S}/externals/nihstro" || die
	rmdir "${S}/externals/cryptopp-cmake"
	mv "${WORKDIR}/cryptopp-cmake-${CRYPTOPP_CMAKE_SHA}" "${S}/externals/cryptopp-cmake" || die
	rmdir "${S}/externals/enet"
	mv "${WORKDIR}/enet-${ENET_SHA}" "${S}/externals/enet" || die
	rmdir "${S}/externals/boost"
	mv "${WORKDIR}/ext-boost-${BOOST_SHA}" "${S}/externals/boost" || die
	rmdir "${S}/externals/xbyak"
	mv "${WORKDIR}/xbyak-${XBYAK_SHA}" "${S}/externals/xbyak" || die
	rmdir "${S}/externals/cpp-jwt"
	mv "${WORKDIR}/cpp-jwt-${CPP_JWT_SHA}" "${S}/externals/cpp-jwt" || die
	rmdir "${S}/externals/libressl"
	mv "${WORKDIR}/ext-libressl-portable-${LIBRESSL_SHA}" "${S}/externals/libressl" || die
	rmdir "${S}/externals/soundtouch"
	mv "${WORKDIR}/ext-soundtouch-${SOUNDTOUCH_SHA}" "${S}/externals/soundtouch" || die
	rmdir "${S}/externals/teakra"
	mv "${WORKDIR}/teakra-${TEAKRA_SHA}" "${S}/externals/teakra" || die
	rmdir "${S}/externals/dynarmic"
	mv "${WORKDIR}/dynarmic-${DYNARMIC_SHA}" "${S}/externals/dynarmic" || die
	rmdir "${S}/externals/discord-rpc"
	mv "${WORKDIR}/discord-rpc-${DISCORD_RPC_SHA}" "${S}/externals/discord-rpc" || die
	rmdir "${S}/externals/cubeb/googletest"
	mv "${WORKDIR}/googletest-${GOOGLETEST_SHA}" "${S}/externals/cubeb/googletest" || die
	rmdir "${S}/externals/cubeb/cmake/sanitizers-cmake"
	mv "${WORKDIR}/sanitizers-cmake-${SANITIZERS_CMAKE_SHA}" "${S}/externals/cubeb/cmake/sanitizers-cmake" || die
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


